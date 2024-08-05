import 'package:http/http.dart' as http;
import 'dart:convert';
import '../models/employee_model.dart';

class EmployeeRemoteDataSource {
  static const String _baseUrl =
      "https://free-ap-south-1.cosmocloud.io/development/api/employee";

  static final EmployeeRemoteDataSource instance =
      EmployeeRemoteDataSource._constructor();

  factory EmployeeRemoteDataSource() {
    return instance;
  }

  EmployeeRemoteDataSource._constructor();

  static Map<String, String> requestHeaders = {
    "Content-Type": "application/json",
    'projectId': '****',
    'environmentId': '****',
  };

  Future<List<EmployeeModel>> getAllEmployees() async {
    final url = Uri.parse('$_baseUrl?limit=10&offset=0');
    final response = await http.get(url, headers: requestHeaders);
    if (response.statusCode == 200) {
      final Map<String, dynamic> responseData = json.decode(response.body);
      final List<dynamic> employeesJson = responseData['data'];
      return employeesJson.map((json) => EmployeeModel.fromJson(json)).toList();
    } else {
      throw Exception('Failed to load employees');
    }
  }

  Future<EmployeeModel> getEmployeeById(String empId) async {
    final response =
        await http.get(Uri.parse('$_baseUrl/$empId'), headers: requestHeaders);
    if (response.statusCode == 200) {
      return EmployeeModel.fromJson(json.decode(response.body));
    } else {
      throw Exception('Failed to load employee');
    }
  }

  Future<void> addEmployee(EmployeeModel employee) async {
    final response = await http.post(
      Uri.parse(_baseUrl),
      headers: requestHeaders,
      body: json.encode(employee.toJson()),
    );
    if (response.statusCode != 201) {
      throw Exception('Failed to add employee');
    }
  }

  Future<void> deleteEmployee(String empId) async {
    final response = await http.delete(Uri.parse('$_baseUrl/$empId'),
        headers: requestHeaders, body: '{}');
    if (response.statusCode != 200) {
      throw Exception('Failed to delete employee');
    }
  }
}
