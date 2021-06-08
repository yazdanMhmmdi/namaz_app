class MarjaeModel {
  String error;
  String errorMessage;
  List<Data> data;

  MarjaeModel({this.error, this.errorMessage, this.data});

  MarjaeModel.fromJson(Map<String, dynamic> json) {
    error = json['error'];
    errorMessage = json['error_message'];
    if (json['data'] != null) {
      data = new List<Data>();
      json['data'].forEach((v) {
        data.add(new Data.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['error'] = this.error;
    data['error_message'] = this.errorMessage;
    if (this.data != null) {
      data['data'] = this.data.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class Data {
  String id;
  String name;
  String pictureSizeSmall;
  String pictureSizeLarge;

  Data({this.id, this.name, this.pictureSizeSmall, this.pictureSizeLarge});

  Data.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    name = json['name'];
    pictureSizeSmall = json['picture_size_small'];
    pictureSizeLarge = json['picture_size_large'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['name'] = this.name;
    data['picture_size_small'] = this.pictureSizeSmall;
    data['picture_size_large'] = this.pictureSizeLarge;
    return data;
  }
}
