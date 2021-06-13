class AhkamModel {
  List<Ahkam> ahkam;
  String error;
  String errorMessage;
  Data data;

  AhkamModel({this.ahkam, this.error, this.errorMessage, this.data});

  AhkamModel.fromJson(Map<String, dynamic> json) {
    if (json['ahkam'] != null) {
      ahkam = new List<Ahkam>();
      json['ahkam'].forEach((v) {
        ahkam.add(new Ahkam.fromJson(v));
      });
    }
    error = json['error'];
    errorMessage = json['error_message'];
    data = json['data'] != null ? new Data.fromJson(json['data']) : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    if (this.ahkam != null) {
      data['ahkam'] = this.ahkam.map((v) => v.toJson()).toList();
    }
    data['error'] = this.error;
    data['error_message'] = this.errorMessage;
    if (this.data != null) {
      data['data'] = this.data.toJson();
    }
    return data;
  }
}

class Ahkam {
  String id;
  String marjaeId;
  String title;

  Ahkam({this.id, this.marjaeId, this.title});

  Ahkam.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    marjaeId = json['marjae_id'];
    title = json['title'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['marjae_id'] = this.marjaeId;
    data['title'] = this.title;
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
