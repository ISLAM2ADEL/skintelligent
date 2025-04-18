class Endpoint {
  // static String baseUrl = "https://food-api-omega.vercel.app/api/v1/";
  static String baseUrl = "http://skintelligent.runasp.net";
  // static String signIn = "user/signin";
  static String signIn = "/api/auth/login";
  static String signUp = "user/signup";
static String doctorById(String id) => "/api/doctors/$id";
  static String getUserDataEndPoint(id) {
    return "user/get-user/$id";
  }
}

class ApiKey {
  static const String status = "statusCode";
  static const String errorMessage = "message";

  // Auth-related
  static const String email = "email";
  static const String password = "password";
  static const String confirmPassword = "confirmPassword";
  static const String token = "token";

  // Doctor/User info
  static const String id = "id";
  static const String name = "name"; // fallback if needed
  static const String firstName = "firstName";
  static const String lastName = "lastName";
  static const String gender = "gender";
  static const String dateOfBirth = "dateOfBirth";
  static const String phone = "phoneNumber";
  static const String licenseNumber = "licenseNumber";
  static const String experienceYears = "experienceYears";
  static const String defaultExaminationFee = "defaultExaminationFee";
  static const String defaultConsultationFee = "defaultConsultationFee";
  static const String profilePic = "profilePicture";
  static const String aboutMe = "aboutMe";
  static const String qualification = "qualification";
  static const String isApproved = "isApproved";
  static const String createdDate = "createdDate";
  static const String updatedDate = "updatedDate";

  // Location (if used later)
  static const String location = "location";
}

