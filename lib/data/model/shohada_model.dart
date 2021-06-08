class ShohadaModel {
  List<ShohadaBozorgan> shohadaBozorgan;
  String error;
  String errorMessage;
  Data data;

  ShohadaModel(
      {this.shohadaBozorgan, this.error, this.errorMessage, this.data});

  ShohadaModel.fromJson(Map<String, dynamic> json) {
    if (json['shohadaBozorgan'] != null) {
      shohadaBozorgan = new List<ShohadaBozorgan>();
      json['shohadaBozorgan'].forEach((v) {
        shohadaBozorgan.add(new ShohadaBozorgan.fromJson(v));
      });
    }
    error = json['error'];
    errorMessage = json['error_message'];
    data = json['data'] != null ? new Data.fromJson(json['data']) : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    if (this.shohadaBozorgan != null) {
      data['shohadaBozorgan'] =
          this.shohadaBozorgan.map((v) => v.toJson()).toList();
    }
    data['error'] = this.error;
    data['error_message'] = this.errorMessage;
    if (this.data != null) {
      data['data'] = this.data.toJson();
    }
    return data;
  }
}

class ShohadaBozorgan {
  String id;
  String name;
  String pictureSizeSmall;
  String pictureSizeLarge;
  String titleText;

  ShohadaBozorgan(
      {this.id,
      this.name,
      this.pictureSizeSmall,
      this.pictureSizeLarge,
      this.titleText});

  ShohadaBozorgan.fromJson(Map<String, dynamic> json) {
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

class Data {
  int totalPages;
  String currentPage;
  int offsetPage;

  Data({this.totalPages, this.currentPage, this.offsetPage});

  Data.fromJson(Map<String, dynamic> json) {
    totalPages = json['total_pages'];
    currentPage = json['current_page'];
    offsetPage = json['offset_page'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['total_pages'] = this.totalPages;
    data['current_page'] = this.currentPage;
    data['offset_page'] = this.offsetPage;
    return data;
  }
}
