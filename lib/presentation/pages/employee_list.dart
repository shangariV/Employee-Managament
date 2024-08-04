import 'package:employee_management/presentation/pages/employee_detail.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../controllers/employee_controller.dart';
import 'add_employee.dart';

class EmployeeListPage extends StatelessWidget {
  const EmployeeListPage({super.key});

  @override
  Widget build(BuildContext context) {
    final EmployeeController controller = Get.find();
    return Scaffold(
      appBar: AppBar(
        title: const Text('Employee List'),
        backgroundColor: Colors.blueAccent,
      ),
      body: Obx(() {
        if (controller.isLoading.value) {
          return const Center(child: CircularProgressIndicator());
        }

        if (controller.errorMessage.isNotEmpty) {
          return Center(child: Text(controller.errorMessage.value));
        }

        if (controller.employees.isEmpty) {
          return const Center(child: Text('No Employees in the system'));
        }

        return ListView.builder(
          itemCount: controller.employees.length,
          itemBuilder: (context, index) {
            final employee = controller.employees[index];
            return Card(
              color: Colors.white,
              child: ListTile(
                title: Text(employee.name),
                subtitle: Text(employee.empId ?? ""),
                onTap: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => EmployeeDetailsPage(empId: employee.empId ?? ""),
                    ),
                  );
                },
                trailing: IconButton(
                  icon: const Icon(Icons.delete),
                  onPressed: () async {
                    await controller.deleteEmployeee(employee.empId ?? "");
                    if (controller.errorMessage.isNotEmpty) {
                      Get.snackbar('Error', controller.errorMessage.value);
                    }
                  },
                ),
              ),
            );
          },
        );
      }),
      floatingActionButton: FloatingActionButton(
        backgroundColor: Colors.blueAccent,
        onPressed: () {
          Navigator.push(
            context,
            MaterialPageRoute(builder: (context) => const AddEmployeePage()),
          );
        },
        child: const Icon(Icons.add),
      ),
    );
  }
}
