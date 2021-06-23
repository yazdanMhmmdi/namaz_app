class VideoDetailsModel {
  String error;
  String errorMessage;
  Data data;

  VideoDetailsModel({this.error, this.errorMessage, this.data});

  VideoDetailsModel.fromJson(Map<String, dynamic> json) {
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
  String thumbnail;
  String video;
  String title;
  String liked;

  Data({this.id, this.thumbnail, this.video, this.title, this.liked});

  Data.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    thumbnail = json['thumbnail'];
    video = json['video'];
    title = json['title'];
    liked = json['liked'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['thumbnail'] = this.thumbnail;
    data['video'] = this.video;
    data['title'] = this.title;
    data['liked'] = this.liked;
    return data;
  }
}
