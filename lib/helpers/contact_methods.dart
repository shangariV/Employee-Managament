enum ContactMethodType { EMAIL, PHONE }

extension ContactMethodTypeExtension on ContactMethodType {
  String get displayName {
    switch (this) {
      case ContactMethodType.EMAIL:
        return 'Email';
      case ContactMethodType.PHONE:
        return 'Phone';
    }
  }

  String get methodName {
    switch (this) {
      case ContactMethodType.EMAIL:
        return 'EMAIL';
      case ContactMethodType.PHONE:
        return 'PHONE';
    }
  }
}
