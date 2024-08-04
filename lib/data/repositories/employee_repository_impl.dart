import '../../domain/entities/employee.dart';
import '../../domain/repositories/employee_repository.dart';
import '../datasources/employee_remote_data_source.dart';
import '../models/employee_model.dart';

class EmployeeRepositoryImpl implements EmployeeRepository {
  final EmployeeRemoteDataSource remoteDataSource;

  EmployeeRepositoryImpl({required this.remoteDataSource});

  @override
  Future<List<Employee>> getAllEmployees() async {
    return await remoteDataSource.getAllEmployees();
  }

  @override
  Future<Employee> getEmployeeById(String empId) async {
    return await remoteDataSource.getEmployeeById(empId);
  }

  @override
  Future<void> addEmployee(Employee employee) async {
    await remoteDataSource.addEmployee(EmployeeModel(
        name: employee.name, empId: '', addressLine1: employee.addressLine1,
        city: employee.city, country: employee.country, zipCode: employee.zipCode, contactMethods: employee.contactMethods));
  }

  @override
  Future<void> deleteEmployee(String empId) async {
    await remoteDataSource.deleteEmployee(empId);
  }
}
