import 'dart:convert';
import 'package:http/http.dart' as http;
import 'employee.dart';

class ApiService {
  static const String baseUrl = 'http://192.168.166.144:8080/employees';

  Future<List<Employee>> getEmployees() async {
    final response = await http.get(Uri.parse(baseUrl));
    if (response.statusCode == 200) {
      Iterable jsonResponse = json.decode(response.body);
      return jsonResponse.map((employee) => Employee.fromJson(employee)).toList();
    } else {
      throw Exception('Failed to load employees');
    }
  }

  Future<Employee> getEmployeeById(String id) async {
    final response = await http.get(Uri.parse('$baseUrl/$id'));
    if (response.statusCode == 200) {
      return Employee.fromJson(json.decode(response.body));
    } else {
      throw Exception('Failed to load employee');
    }
  }

  Future<Employee> createEmployee(Employee employee) async {
    final response = await http.post(
      Uri.parse(baseUrl),
      headers: {'Content-Type': 'application/json'},
      body: json.encode(employee.toJson()),
    );
    if (response.statusCode == 201) {
      return Employee.fromJson(json.decode(response.body));
    } else {
      throw Exception('Failed to create employee');
    }
  }

  Future<Employee> updateEmployee(String id, Employee employee) async {
    final response = await http.put(
      Uri.parse('$baseUrl/$id'),
      headers: {'Content-Type': 'application/json'},
      body: json.encode(employee.toJson()),
    );
    if (response.statusCode == 200) {
      return Employee.fromJson(json.decode(response.body));
    } else {
      throw Exception('Failed to update employee');
    }
  }

  Future<void> deleteEmployee(String id) async {
    final response = await http.delete(Uri.parse('$baseUrl/$id'));
    if (response.statusCode != 204) {
      throw Exception('Failed to delete employee');
    }
  }
}
