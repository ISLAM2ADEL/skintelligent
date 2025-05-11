class Endpoint {
  // static String baseUrl = "https://food-api-omega.vercel.app/api/v1/";
  static String baseUrl = "http://skintelligent.runasp.net";
  // static String signIn = "user/signin";
  static String signIn = "/api/auth/login";
  static String forgetPassword = "/api/auth/forgot-password";
  static String resetPassword = "/api/auth/reset-password";
  static String getDoctors = "/api/doctors";
  static String signUp = "/api/auth/register";
  static String appointmentByWeek = '/api/appointments/week';
  static String user_booking_appointments = "/api/patients/appointments";
  static String makeBooking = '/api/appointments/book';
  static String getSummary =
      "https://779c-34-124-251-195.ngrok-free.app/summarize"; 
  static String doctorById(num id) => "/api/doctors/$id";
  static String cancelBooking({required int appointmentid}) {
    return "/api/patient/appointments/$appointmentid/cancel";
  }

  static String getUserDataEndPoint(id) {
    return "user/get-user/$id";
  }

  // review endpoint
  static String getReviews(int doctorID) {
    return "/api/reviews/doctor/$doctorID";
  }

  static String makeReviews() {
    return "/api/reviews";
  }
}

class ApiKey {
  static const String statusCode = "statusCode";
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
  static String Authorization = "Authorization";
  // Location (if used later)
  static const String location = "location";
  // Available booking
  static const String startTime = "startTime";
  static const String endTime = "endTime";
  static const String isCanceled = "isCanceled";
  static const String isBooked = "isBooked";
  static const String repeatDay = "repeatDay";
  static const String repeatUntil = "repeatUntil";
  // Get All Reviews
  static const String comment = "comment";
  static const String rating = "rating";
  static const String patientName = "patientName";
  static const String patientImage = "patientImage";
  static const String createdAt = "createdAt";
  static const String pageIndex = "pageIndex";
  static const String pageSize = "pageSize";
  static const String count = "count";
  static const String data = "data";
// Make Review
  static const String doctorId = "doctorId";
  static const String patientId = "patientId";
// Booking
  static const String appointmentId = "appointmentId";
// Get User Booking
  static const String doctorName = "doctorName";
  static const String clinicName = "clinicName";
  static const String clinicAddress = "clinicAddress";

  // summarize model
  static const String role = "role";
  static const String content = "content";
  static const String summaryMessage = "messages";
}
