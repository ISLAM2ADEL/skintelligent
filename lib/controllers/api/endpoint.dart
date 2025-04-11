class Endpoint {
  // static String baseUrl = "https://food-api-omega.vercel.app/api/v1/";
  static String baseUrl = "http://skintelligent.runasp.net";
  // static String signIn = "user/signin";
  static String signIn = "/api/auth/login";
  static String signUp = "user/signup";
  static String getUserDataEndPoint(id) {
    return "user/get-user/$id";
  }
}

class ApiKey {
  static String status = "statusCode";
  static String errorMessage = "message";
  static String email = "email";
  static String password = "password";
  static String token = "token";
  static String message = "message";
  static String id = "id";
  static String name = "name";
  static String phone = "phone";
  static String confirmPassword = "confirmPassword";
  static String location = "location";
  static String profilePic = "profilePic";
}
