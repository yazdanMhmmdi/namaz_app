class LikeAhkamModel {
  String error;
  String errorMessage;
  String status;

  LikeAhkamModel({this.error, this.errorMessage, this.status});

  LikeAhkamModel.fromJson(Map<String, dynamic> json) {
    error = json['error'];
    errorMessage = json['error_message'];
    status = json['status'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['error'] = this.error;
    data['error_message'] = this.errorMessage;
    data['status'] = this.status;
    return data;
  }
}
