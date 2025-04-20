class Endpoint {
  // static String baseUrl = "https://food-api-omega.vercel.app/api/v1/";
  static String baseUrl = "http://skintelligent.runasp.net";
  // static String signIn = "user/signin";
  static String signIn = "/api/auth/login";
  static String forgetPassword = "/api/auth/forgot-password";
  static String resetPassword = "/api/auth/reset-password";
  static String getDoctors = "/api/doctors";
  static String signUp = "/api/auth/register";
  static String appointmentByWeek = '/api/appointments/week' ;
  static String doctorById(num id) => "/api/doctors/$id";
  static String getUserDataEndPoint(id) {
    return "user/get-user/$id";
  }
}

class ApiKey {
  static const String status = "statusCode";
  static const String errorMessage = "message";
  static String message = "message";

  // Auth-related
  static const String email = "email";
  static const String password = "password";
  static const String confirmPassword = "confirmPassword";
  static const String token = "token";
  static const String resetOTP = "resetOTP";

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
  // Available booking
  static const String startTime = "startTime"; 
  static const String endTime = "endTime";
  static const String isCanceled = "isCanceled";
  static const String isRepeating = "isRepeating";
  static const String repeatDay = "repeatDay";
  static const String repeatUntil = "repeatUntil";

}
