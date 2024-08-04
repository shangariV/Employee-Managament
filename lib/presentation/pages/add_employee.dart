import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../domain/entities/employee.dart';
import '../../helpers/app_strings.dart';
import '../../helpers/contact_methods.dart';
import '../../helpers/validation_utils.dart';
import '../controllers/employee_controller.dart';

class AddEmployeePage extends StatefulWidget {
  const AddEmployeePage({super.key});

  @override
  _AddEmployeePageState createState() => _AddEmployeePageState();
}

class _AddEmployeePageState extends State<AddEmployeePage> {
  final _formKey = GlobalKey<FormState>();
  String name = '';
  String line1 = '';
  String city = '';
  String country = '';
  String zipCode = '';
  final EmployeeController controller = Get.find();

  bool _isContactMethodValid(ContactMethod contactMethod) {
    if (contactMethod.method == ContactMethodType.EMAIL.methodName) {
      return ValidationUtils.validateEmail(contactMethod.value) == null;
    } else if (contactMethod.method == ContactMethodType.PHONE.methodName) {
      return ValidationUtils.validatePhone(contactMethod.value) == null;
    }
    return false;
  }

  bool _areAllContactMethodsValid() {
    for (var contactMethod in controller.contactMethods) {
      if (!_isContactMethodValid(contactMethod)) {
        return false;
      }
    }
    return true;
  }

  void _submitForm() {
    if (_formKey.currentState!.validate() && controller.contactMethods.isNotEmpty && controller.contactMethods.first.method.isNotEmpty) {
      _formKey.currentState!.save();
      final employee = Employee(
        name: name,
        addressLine1: line1,
        city: city,
        country: country,
        zipCode: zipCode,
        contactMethods: controller.contactMethods,
      );
      controller.addNewEmployee(employee);
      Navigator.pop(context);
      controller.resetContactMethods();
    } else {
      Get.showSnackbar(
        const GetSnackBar(
          title: AppStrings.error,
          message: AppStrings.addAtLeastOneContact,
          icon: Icon(Icons.refresh),
          duration: Duration(seconds: 3),
        ),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        FocusScope.of(context).unfocus();
      },
      child: Scaffold(
        appBar: AppBar(
          title: const Text('Add Employee'),
        ),
        body: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Form(
            key: _formKey,
            autovalidateMode: AutovalidateMode.onUserInteraction,
            child: ListView(
              children: [
                TextFormField(
                  decoration: const InputDecoration(labelText: 'Name'),
                  validator: (value) =>
                  value!.isEmpty ? AppStrings.pleaseEnterName : null,
                  onChanged: (value) {
                    setState(() {
                      name = value;
                    });
                  },
                  onSaved: (value) => name = value!,
                ),
                const SizedBox(height: 20),
                TextFormField(
                  decoration: const InputDecoration(labelText: 'Address Line 1'),
                  validator: (value) =>
                  value!.isEmpty ? AppStrings.pleaseEnterAddress : null,
                  onChanged: (value) {
                    setState(() {
                      line1 = value;
                    });
                  },
                  onSaved: (value) => line1 = value!,
                ),
                const SizedBox(height: 20),
                TextFormField(
                  decoration: const InputDecoration(labelText: 'City'),
                  validator: (value) =>
                  value!.isEmpty ? AppStrings.pleaseEnterCity : null,
                  onChanged: (value) {
                    setState(() {
                      city = value;
                    });
                  },
                  onSaved: (value) => city = value!,
                ),
                const SizedBox(height: 20),
                TextFormField(
                  decoration: const InputDecoration(labelText: 'Country'),
                  validator: (value) =>
                  value!.isEmpty ? AppStrings.pleaseEnterCountry : null,
                  onChanged: (value) {
                    setState(() {
                      country = value;
                    });
                  },
                  onSaved: (value) => country = value!,
                ),
                const SizedBox(height: 20),
                TextFormField(
                  decoration: const InputDecoration(labelText: 'Zip Code'),
                  keyboardType: TextInputType.number,
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return AppStrings.pleaseEnterZipCode;
                    }
                    if (!RegExp(r'^\d{6}$').hasMatch(value)) {
                      return AppStrings.pleaseEnterValidZipCode;
                    }
                    return null;
                  },
                  onChanged: (value) {
                    setState(() {
                      zipCode = value;
                    });
                  },
                  onSaved: (value) => zipCode = value!,
                ),
                const SizedBox(height: 20),
                Obx(() => Column(
                  children: [
                    ...controller.contactMethods.asMap().entries.map((entry) {
                      int index = entry.key;
                      ContactMethod contactMethod = entry.value;
                      return Row(
                        children: [
                          Expanded(
                            child: DropdownButtonFormField<String>(
                              decoration: const InputDecoration(labelText: 'Contact Method'),
                              value: contactMethod.method.isEmpty ? null : contactMethod.method,
                              items: ContactMethodType.values.map((method) {
                                return DropdownMenuItem(
                                  value: method.methodName,
                                  child: Text(method.displayName),
                                );
                              }).toList(),
                              onChanged: (value) {
                                if (value != null) {
                                  setState(() {
                                    controller.updateContactMethod(index, value, contactMethod.value);
                                  });
                                }
                              },
                            ),
                          ),
                          const SizedBox(width: 8),
                          Expanded(
                            child: TextFormField(
                              decoration: const InputDecoration(labelText: 'Value'),
                              initialValue: contactMethod.value,
                              validator: (value) {
                                if (contactMethod.method == ContactMethodType.EMAIL.methodName) {
                                  return ValidationUtils.validateEmail(value);
                                } else if (contactMethod.method == ContactMethodType.PHONE.methodName) {
                                  return ValidationUtils.validatePhone(value);
                                }
                                return null;
                              },
                              onChanged: (value) {
                                setState(() {
                                  controller.updateContactMethod(index, contactMethod.method, value);
                                });
                              },
                              keyboardType: contactMethod.method == ContactMethodType.EMAIL.methodName
                                  ? TextInputType.emailAddress
                                  : TextInputType.phone,
                            ),
                          ),
                          IconButton(
                            icon: const Icon(Icons.delete),
                            onPressed: () {
                              setState(() {
                                controller.removeContactMethod(index);
                              });
                            },
                          ),
                        ],
                      );
                    }),
                    ElevatedButton(
                      onPressed: _areAllContactMethodsValid() ? () {
                        setState(() {
                          controller.addContactMethod();
                        });
                      } : null,
                      child: const Text(AppStrings.addContactMethod),
                    ),
                  ],
                )),
                const SizedBox(height: 16),
                ElevatedButton(
                  onPressed: _submitForm,
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.blueAccent,
                  ),
                  child: const Text(AppStrings.addContact, style: TextStyle(
                      color: Colors.white
                  ),),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
