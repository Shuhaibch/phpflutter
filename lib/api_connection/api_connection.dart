class Api {
  static const hostConnect = 'http://192.168.1.22/sinet_app';
  static const hostConnectuser = '$hostConnect/user';

// signUp User
  static const signUp = "$hostConnectuser/signup.php";
  // Get all data
  static const getall = "$hostConnectuser/getuser.php";
  static const deleteUser = "$hostConnectuser/deleteuser.php";
  static const editUser = "$hostConnectuser/updateuser.php";
}
