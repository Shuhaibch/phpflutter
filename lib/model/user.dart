// ignore_for_file: public_member_api_docs, sort_constructors_first, non_constant_identifier_names
class User {
  int user_Id;
  String user_name;
  String user_email;
  String user_password;
  User({
    required this.user_Id,
    required this.user_name,
    required this.user_email,
    required this.user_password,
  });

  Map<String, dynamic> toJson() => {
    "user_Id":user_Id.toString(),
   "user_name":user_name,
   "user_email":user_email,
   "user_password":user_password
  };
}
