import '../repositories/employee_repository.dart';

class DeleteEmployee {
  final EmployeeRepository repository;

  DeleteEmployee(this.repository);

  Future<void> call(String empId) async {
    await repository.deleteEmployee(empId);
  }
}
