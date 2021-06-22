class LikeNarrativesModel {
  String status;
  String error;
  String errorMessage;

  LikeNarrativesModel({this.status, this.error, this.errorMessage});

  LikeNarrativesModel.fromJson(Map<String, dynamic> json) {
    status = json['status'];
    error = json['error'];
    errorMessage = json['error_message'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['status'] = this.status;
    data['error'] = this.error;
    data['error_message'] = this.errorMessage;
    return data;
  }
}
