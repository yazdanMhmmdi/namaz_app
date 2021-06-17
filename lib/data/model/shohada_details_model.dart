class ShohadaDetailsModel {
  String error;
  String errorMessage;
  Data data;

  ShohadaDetailsModel({this.error, this.errorMessage, this.data});

  ShohadaDetailsModel.fromJson(Map<String, dynamic> json) {
    error = json['error'];
    errorMessage = json['error_message'];
    data = json['data'] != null ? new Data.fromJson(json['data']) : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['error'] = this.error;
    data['error_message'] = this.errorMessage;
    if (this.data != null) {
      data['data'] = this.data.toJson();
    }
    return data;
  }
}

class Data {
  String id;
  String name;
  String pictureSizeSmall;
  String pictureSizeLarge;
  String titleText;

  Data(
      {this.id,
      this.name,
      this.pictureSizeSmall,
      this.pictureSizeLarge,
      this.titleText});

  Data.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    name = json['name'];
    pictureSizeSmall = json['picture_size_small'];
    pictureSizeLarge = json['picture_size_large'];
    titleText = json['title_text'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['name'] = this.name;
    data['picture_size_small'] = this.pictureSizeSmall;
    data['picture_size_large'] = this.pictureSizeLarge;
    data['title_text'] = this.titleText;
    return data;
  }
}
