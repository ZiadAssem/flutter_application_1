import 'package:meta/meta.dart';

@immutable
class User {
  final String fullName;
  final String email;
  final String phoneNo;
  const User({
    required this.fullName,
    required this.email,
    required this.phoneNo,
  });


}