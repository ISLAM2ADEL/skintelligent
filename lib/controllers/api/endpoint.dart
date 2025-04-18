class Endpoint {
  // static String baseUrl = "https://food-api-omega.vercel.app/api/v1/";
  static String baseUrl = "http://skintelligent.runasp.net";
  // static String signIn = "user/signin";
  static String signIn = "/api/auth/login";
  static String forgetPassword = "/api/auth/forgot-password";
  static String resetPassword = "/api/auth/reset-password";
  static String getDoctors = "/api/doctors";
  static String signUp = "/api/auth/register";
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
  static String resetOTP = "resetOTP";
  static String name = "name";
  static String firstName = "firstName";
  static String lastName = "lastName";
  static String dateOfBirth = "dateOfBirth";
  static String licenseNumber = "licenseNumber";
  static String experienceYears = "experienceYears";
  static String defaultExaminationFee = "defaultExaminationFee";
  static String defaultConsultationFee = "defaultConsultationFee";
  static String qualification = "qualification";
  static String phone = "phone";
  static String confirmPassword = "confirmPassword";
  static String location = "location";
  static String profilePic = "profilePic";
}
