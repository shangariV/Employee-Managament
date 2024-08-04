import 'package:get/get.dart';
import '../../domain/entities/employee.dart';
import '../../domain/usecases/get_all_employees.dart';
import '../../domain/usecases/get_employee_by_id.dart';
import '../../domain/usecases/add_employee.dart';
import '../../domain/usecases/delete_employee.dart';
import '../../helpers/validation_utils.dart';

class EmployeeController extends GetxController {
  final GetAllEmployees getAllEmployees;
  final GetEmployeeById getEmployeeById;
  final AddEmployee addEmployee;
  final DeleteEmployee deleteEmployee;

  EmployeeController({
    required this.getAllEmployees,
    required this.getEmployeeById,
    required this.addEmployee,
    required this.deleteEmployee,
  });

  var employees = <Employee>[].obs;
  var isLoading = false.obs;
  var errorMessage = ''.obs;
  var contactMethods = <ContactMethod>[].obs;


  @override
  void onInit() {
    super.onInit();
    loadEmployees();
  }

  Future<void> loadEmployees() async {
    isLoading.value = true;
    errorMessage.value = '';
    try {
      final employeeList = await getAllEmployees();
      employees.assignAll(employeeList);
    } catch (e) {
      errorMessage.value = 'Failed to load employees';
    } finally {
      isLoading.value = false;
    }
  }

  Future<void> addNewEmployee(Employee employee) async {
    try {
      await addEmployee(employee);
      loadEmployees();
    } catch (e) {
      errorMessage.value = 'Failed to add employee';
    }
  }

  Future<void> deleteEmployeee(String empId) async {
    isLoading.value = true;
    errorMessage.value = '';
    try {
      await deleteEmployee(empId);
      employees.removeWhere((employee) => employee.empId == empId);
    } catch (e) {
      errorMessage.value = 'Failed to delete employee';
    } finally {
      isLoading.value = false;
    }
  }

  void resetContactMethods() {
    contactMethods.clear();
  }

  void addContactMethod() {
    contactMethods.add(ContactMethod(method: '', value: ''));
  }

  void removeContactMethod(int index) {
    if (index >= 0 && index < contactMethods.length) {
      contactMethods.removeAt(index);
    }
  }

  void updateContactMethod(int index, String newMethod, String newValue) {
    if (index >= 0 && index < contactMethods.length) {
      contactMethods[index] = ContactMethod(
        method: newMethod,
        value: newValue,
      );
    }
  }

  bool isContactMethodValid(ContactMethod contactMethod) {
    if (contactMethod.method == 'EMAIL') {
      return ValidationUtils.validateEmail(contactMethod.value) == null;
    } else if (contactMethod.method == 'PHONE') {
      return ValidationUtils.validatePhone(contactMethod.value) == null;
    }
    return false;
  }

  bool areAllContactMethodsValid() {
    for (var contactMethod in contactMethods) {
      if (!isContactMethodValid(contactMethod)) {
        return false;
      }
    }
    return true;
  }
}
