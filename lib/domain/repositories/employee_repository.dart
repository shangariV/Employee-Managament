import '../entities/employee.dart';

abstract class EmployeeRepository {
  Future<List<Employee>> getAllEmployees();
  Future<Employee> getEmployeeById(String empId);
  Future<void> addEmployee(Employee employee);
  Future<void> deleteEmployee(String empId);
}
