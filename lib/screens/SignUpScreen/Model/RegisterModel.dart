class Registermodel {
  bool? status;
  String? message;
  RegisterData? data;

  Registermodel({this.status, this.message, this.data});

  Registermodel.fromJson(Map<String, dynamic> json) {
    status = json['status'];
    message = json['message'];
    data =
        json['data'] != null ? new RegisterData.fromJson(json['data']) : null;
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

  RegisterData(
      {this.id,
      this.name,
      this.email,
      this.phone,
      this.image,
      this.points,
      this.credit,
      this.token});

  RegisterData.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    name = json['name'];
    email = json['email'];
    phone = json['phone'];
    image = json['image'];
    points = json['points'];
    credit = json['credit'];
    token = json['token'];
  }
}
