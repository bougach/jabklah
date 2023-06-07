
import 'AccountType.dart';

class ProspectRequest {
  String firstName;
  String lastName;
  String username;
  String email;
  String phone;
  String cin;
  String type;

  ProspectRequest({
    required this.firstName,
    required this.lastName,
    required this.username,
    required this.email,
    required this.phone,
    required this.cin,
    required this.type,
  });

  Map<String, dynamic> toJson() {
    return<String, dynamic> {
      'firstName': firstName,
      'lastName': lastName,
      'username': username,
      'email': email,
      'phone': phone,
      'cin': cin,
      'type': type.toString(),
    };
  }
}
