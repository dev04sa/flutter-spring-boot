class Employee {
  String? id;
  String name;
  String position;
  double salary;

  Employee({this.id, required this.name, required this.position, required this.salary});

  factory Employee.fromJson(Map<String, dynamic> json) {
    return Employee(
      id: json['id'],
      name: json['name'],
      position: json['position'],
      salary: json['salary'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'name': name,
      'position': position,
      'salary': salary,
    };
  }
}
