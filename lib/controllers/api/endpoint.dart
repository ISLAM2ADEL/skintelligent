class Endpoint {
  static final String baseUrl = 'https://student.valuxapps.com/api/';
  static final String signIn = 'login';
  static final String signUp = 'register';
  // static final String checkEmail = 'user/check-email';
  // static final String updateUser = 'user/update';
  static final String logout = 'logout';
  static String getUserDataEndPoint(id) {
    return 'user/get-user/$id';
  }
}

class ApiKey {
  static String image = 'image'; 
  static String points = 'points'; 
  static String credit = 'credit'; 
  static String data = 'data';
  static String status = 'status';
  static String errorMessage = 'message';
  static String email = 'email';
  static String password = 'password';
  static String token = 'token';
  static String id = 'id';
  static String message = 'message';
  static String name = 'name';
  static String phone = 'phone';
  static String confirmPassword = 'confirmPassword';
  static String profilePic = 'profilePic';
  static String location = 'location';
}
