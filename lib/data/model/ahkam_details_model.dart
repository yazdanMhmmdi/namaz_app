class AhkamDetailsModel {
  String error;
  String errorMessage;
  Data data;

  AhkamDetailsModel({this.error, this.errorMessage, this.data});

  AhkamDetailsModel.fromJson(Map<String, dynamic> json) {
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
  String marjaeId;
  String title;
  String titleText;
  String pictureSizeSmall;
  String pictureSizeLarge;
  String pictureSizeXLarge;
  String liked;

  Data(
      {this.id,
      this.marjaeId,
      this.title,
      this.titleText,
      this.pictureSizeSmall,
      this.pictureSizeLarge,
      this.pictureSizeXLarge,
      this.liked});

  Data.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    marjaeId = json['marjae_id'];
    title = json['title'];
    titleText = json['title_text'];
    pictureSizeSmall = json['picture_size_small'];
    pictureSizeLarge = json['picture_size_large'];
    pictureSizeXLarge = json['picture_size_x_large'];
    liked = json['liked'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['marjae_id'] = this.marjaeId;
    data['title'] = this.title;
    data['title_text'] = this.titleText;
    data['picture_size_small'] = this.pictureSizeSmall;
    data['picture_size_large'] = this.pictureSizeLarge;
    data['picture_size_x_large'] = this.pictureSizeXLarge;
    data['liked'] = this.liked;
    return data;
  }
}
