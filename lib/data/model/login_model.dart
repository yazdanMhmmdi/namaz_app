class LoginModel {
  String userId;
  String error;
  String errorMessage;

  LoginModel({this.userId, this.error, this.errorMessage});

  LoginModel.fromJson(Map<String, dynamic> json) {
    userId = json['user_id'];
    error = json['error'];
    errorMessage = json['error_message'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['user_id'] = this.userId;
    data['error'] = this.error;
    data['error_message'] = this.errorMessage;
    return data;
  }
}
