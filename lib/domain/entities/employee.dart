class Employee {
  final String name;
  final String? empId;
  final String addressLine1;
  final String city;
  final String country;
  final String zipCode;
  final List<ContactMethod> contactMethods;

  Employee({
    required this.name,
    this.empId,
    required this.addressLine1,
    required this.city,
    required this.country,
    required this.zipCode,
    required this.contactMethods,
  });
}

class ContactMethod {
  final String method;
  final String value;

  ContactMethod({required this.method, required this.value});
}
