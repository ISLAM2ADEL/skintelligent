class Registermodel {
  bool? status;
  String? message;
  RegisterData? data;

  Registermodel({this.status, this.message, this.data});

  Registermodel.fromJson(Map<String, dynamic> json) {
    status = json['status'] ?? false; // Ensure default value
    message = json['message'] ?? "Unknown error";
    data = json['data'] != null ? RegisterData.fromJson(json['data']) : null;
  }
}

class RegisterData {
  int? id;
  String? name;
  String? email;
  String? phone;
  String? image;
  int? points;
  int? credit;
  String? token;

  RegisterData({
    this.id,
    this.name,
    this.email,
    this.phone,
    this.image,
    this.points,
    this.credit,
    this.token,
  });

  RegisterData.fromJson(Map<String, dynamic> json) {
    id = json['id'] ?? 0;
    name = json['name'] ?? "Unknown";
    email = json['email'] ?? "";
    phone = json['phone'] ?? "";
    image = json['image'] ?? "";
    points = json['points'] ?? 0;
    credit = json['credit'] ?? 0;
    token = json['token'] ?? "";
  }
}
