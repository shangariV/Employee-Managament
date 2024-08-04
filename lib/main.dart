import 'package:employee_management/presentation/controllers/employee_detail_controller.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'data/datasources/employee_remote_data_source.dart';
import 'data/repositories/employee_repository_impl.dart';
import 'domain/usecases/get_all_employees.dart';
import 'domain/usecases/get_employee_by_id.dart';
import 'domain/usecases/add_employee.dart';
import 'domain/usecases/delete_employee.dart';
import 'presentation/controllers/employee_controller.dart';
import 'presentation/pages/employee_list.dart';

void main() {
  final employeeRemoteDataSource = EmployeeRemoteDataSource();
  final employeeRepository = EmployeeRepositoryImpl(remoteDataSource: employeeRemoteDataSource);
  final getAllEmployees = GetAllEmployees(employeeRepository);
  final getEmployeeById = GetEmployeeById(employeeRepository);
  final addEmployee = AddEmployee(employeeRepository);
  final deleteEmployee = DeleteEmployee(employeeRepository);

  Get.put(EmployeeController(
    getAllEmployees: getAllEmployees,
    getEmployeeById: getEmployeeById,
    addEmployee: addEmployee,
    deleteEmployee: deleteEmployee,
  ));
  Get.lazyPut<EmployeeDetailController>(() => EmployeeDetailController(getEmployeeById: GetEmployeeById(employeeRepository)));

  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Employee Management',
      theme: ThemeData(
        primaryColor: Colors.blueAccent
      ),
      home: const EmployeeListPage(),
    );
  }
}
