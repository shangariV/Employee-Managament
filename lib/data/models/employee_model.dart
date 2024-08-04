import '../../domain/entities/employee.dart';

class EmployeeModel extends Employee {
  EmployeeModel({
    required super.name,
    required String super.empId,
    required super.addressLine1,
    required super.city,
    required super.country,
    required super.zipCode,
    required super.contactMethods,
  });

  factory EmployeeModel.fromJson(Map<String, dynamic> json) {
    return EmployeeModel(
      name: json['name'],
      empId: json['_id'],
      addressLine1: json['address_1'],
        city: json['city'],
        country: json['country'],
        zipCode: json['zipcode'],

      contactMethods: (json['contact'] as List)
          .map((contactJson) => ContactMethod(
        method: contactJson['method'],
        value: contactJson['value'],
      ))
          .toList(),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'name': name,
      'address_1': addressLine1,
      'city': city,
      'country': country,
      'zipcode': zipCode,
      'contact': contactMethods.map((method) => {
        'method': method.method,
        'value': method.value,
      }).toList(),
    };
  }
}
