import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../controllers/employee_detail_controller.dart';

class EmployeeDetailsPage extends StatelessWidget {
  final String empId;

  const EmployeeDetailsPage({super.key, required this.empId});

  @override
  Widget build(BuildContext context) {
    final EmployeeDetailController controller =
        Get.find<EmployeeDetailController>();
    controller.fetchEmployeeDetails(empId);
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.blueAccent,
      ),
      body: Stack(
        children: [
          Container(
            height: MediaQuery.of(context).size.height / 5,
            color: Colors.blueAccent,
          ),
          Obx(() {
            if (controller.isLoading.value) {
              return const Center(child: CircularProgressIndicator());
            } else if (controller.employeeDetails.value != null) {
              final employee = controller.employeeDetails.value!;
              return Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Card(
                    color: Colors.white,
                    margin: EdgeInsets.only(
                        top: MediaQuery.of(context).size.height / 5 - 50,
                        left: 50,
                        right: 50),
                    elevation: 8,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(16),
                    ),
                    child: Padding(
                      padding: const EdgeInsets.all(10.0),
                      child: Column(
                        mainAxisSize: MainAxisSize.min,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(employee.name,
                              style: const TextStyle(fontSize: 18)),
                          Text('${employee.empId}',
                              style: const TextStyle(fontSize: 18)),
                          Text('${employee.addressLine1}, ${employee.city}, ${employee.country}',
                              style: const TextStyle(fontSize: 18)),
                          Text(employee.zipCode,
                              style: const TextStyle(fontSize: 18)),
                      
                        ],
                      ),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(10.0),
                    child: SizedBox(
                      height: MediaQuery.sizeOf(context).height / 2,
                      child: ListView.builder(
                        itemCount: employee.contactMethods.length,
                        itemBuilder: (context, index) {
                          final contact = employee.contactMethods[index];
                          return Card(
                            color: Colors.white,
                            child: Container(
                              padding: const EdgeInsets.all(20),
                              height: 60,
                              width: double.infinity,
                              child: Text('${contact.method}: ${contact.value}',
                                  style: const TextStyle(fontSize: 16)),
                            ),
                          );
                        },
                      ),
                    ),
                  )
                ],
              );
            } else {
              return const Center(child: Text('Employee not found.'));
            }
          }),
        ],
      ),
    );
  }
}
