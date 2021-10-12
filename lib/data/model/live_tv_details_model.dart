class LiveTvDetailModel {
  String error;
  String errorMessage;
  Data data;

  LiveTvDetailModel({this.error, this.errorMessage, this.data});

  LiveTvDetailModel.fromJson(Map<String, dynamic> json) {
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
  String stream;
  String thumbPicture;
  String blurhash;
  String orderNumber;

  Data(
      {this.id,
      this.name,
      this.stream,
      this.thumbPicture,
      this.blurhash,
      this.orderNumber});

  Data.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    name = json['name'];
    stream = json['stream'];
    thumbPicture = json['thumb_picture'];
    blurhash = json['blurhash'];
    orderNumber = json['order_number'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['name'] = this.name;
    data['stream'] = this.stream;
    data['thumb_picture'] = this.thumbPicture;
    data['blurhash'] = this.blurhash;
    data['order_number'] = this.orderNumber;
    return data;
  }
}
