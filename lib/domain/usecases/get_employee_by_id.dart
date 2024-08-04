import '../entities/employee.dart';
import '../repositories/employee_repository.dart';

class GetEmployeeById {
  final EmployeeRepository repository;

  GetEmployeeById(this.repository);

  Future<Employee> call(String empId) async {
    return await repository.getEmployeeById(empId);
  }
}
