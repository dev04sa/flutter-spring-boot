import 'package:flutter/material.dart';
import 'employee.dart';
import 'api_service.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Employee Management',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: EmployeeListScreen(),
    );
  }
}

class EmployeeListScreen extends StatefulWidget {
  @override
  _EmployeeListScreenState createState() => _EmployeeListScreenState();
}

class _EmployeeListScreenState extends State<EmployeeListScreen> {
  final ApiService _apiService = ApiService();
  late Future<List<Employee>> _employeeList;

  @override
  void initState() {
    super.initState();
    _employeeList = _apiService.getEmployees();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Employee Management'),
      ),
      body: FutureBuilder<List<Employee>>(
        future: _employeeList,
        builder: (context, snapshot) {
          if (snapshot.hasData) {
            return ListView.builder(
              itemCount: snapshot.data!.length,
              itemBuilder: (context, index) {
                return ListTile(
                  title: Text(snapshot.data![index].name),
                  subtitle: Text(snapshot.data![index].position),
                  trailing: Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      IconButton(
                        icon: Icon(Icons.edit),
                        onPressed: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) => EmployeeFormScreen(employee: snapshot.data![index]),
                            ),
                          ).then((value) {
                            setState(() {
                              _employeeList = _apiService.getEmployees();
                            });
                          });
                        },
                      ),
                      IconButton(
                        icon: Icon(Icons.delete),
                        onPressed: () {
                          _apiService.deleteEmployee(snapshot.data![index].id!).then((value) {
                            setState(() {
                              _employeeList = _apiService.getEmployees();
                            });
                          });
                        },
                      ),
                    ],
                  ),
                );
              },
            );
          } else if (snapshot.hasError) {
            return Center(child: Text('Failed to load employees'));
          }

          return Center(child: CircularProgressIndicator());
        },
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => EmployeeFormScreen(),
            ),
          ).then((value) {
            setState(() {
              _employeeList = _apiService.getEmployees();
            });
          });
        },
        child: Icon(Icons.add),
      ),
    );
  }
}

class EmployeeFormScreen extends StatefulWidget {
  final Employee? employee;

  EmployeeFormScreen({this.employee});

  @override
  _EmployeeFormScreenState createState() => _EmployeeFormScreenState();
}

class _EmployeeFormScreenState extends State<EmployeeFormScreen> {
  final _formKey = GlobalKey<FormState>();
  late String _name;
  late String _position;
  late double _salary;
  final ApiService _apiService = ApiService();

  @override
  void initState() {
    super.initState();
    _name = widget.employee?.name ?? '';
    _position = widget.employee?.position ?? '';
    _salary = widget.employee?.salary ?? 0.0;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.employee == null ? 'Create Employee' : 'Update Employee'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Form(
          key: _formKey,
          child: Column(
            children: [
              TextFormField(
                initialValue: _name,
                decoration: InputDecoration(labelText: 'Name'),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Please enter a name';
                  }
                  return null;
                },
                onSaved: (value) {
                  _name = value!;
                },
              ),
              TextFormField(
                initialValue: _position,
                decoration: InputDecoration(labelText: 'Position'),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Please enter a position';
                  }
                  return null;
                },
                onSaved: (value) {
                  _position = value!;
                },
              ),
              TextFormField(
                initialValue: _salary.toString(),
                decoration: InputDecoration(labelText: 'Salary'),
                keyboardType: TextInputType.number,
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Please enter a salary';
                  }
                  if (double.tryParse(value) == null) {
                    return 'Please enter a valid number';
                  }
                  return null;
                },
                onSaved: (value) {
                  _salary = double.parse(value!);
                },
              ),
              SizedBox(height: 20),
              ElevatedButton(
                onPressed: () {
                  if (_formKey.currentState!.validate()) {
                    _formKey.currentState!.save();
                    if (widget.employee == null) {
                      _apiService.createEmployee(Employee(name: _name, position: _position, salary: _salary)).then((value) {
                        Navigator.pop(context);
                      });
                    } else {
                      _apiService.updateEmployee(widget.employee!.id!, Employee(id: widget.employee!.id, name: _name, position: _position, salary: _salary)).then((value) {
                        Navigator.pop(context);
                      });
                    }
                  }
                },
                child: Text(widget.employee == null ? 'Create' : 'Update'),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
