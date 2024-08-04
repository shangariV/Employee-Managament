import 'package:get/get.dart';
import '../../domain/entities/employee.dart';
import '../../domain/usecases/get_employee_by_id.dart';

class EmployeeDetailController extends GetxController {
  final GetEmployeeById getEmployeeById;

  EmployeeDetailController({required this.getEmployeeById});

  var employeeDetails = Rxn<Employee>();
  var isLoading = true.obs;
  var errorMessage = ''.obs;

  @override
  void onInit() {
    super.onInit();
    employeeDetails = Rxn<Employee>();
  }

  Future<void>fetchEmployeeDetails(String empId) async {
    isLoading.value = true;
    try {
      final emp = await getEmployeeById(empId);
      employeeDetails.value = emp;
      errorMessage.value = '';
    } catch (e) {
      errorMessage.value = 'Failed to load employee details';
    } finally {
      isLoading.value = false;
    }
  }
}
