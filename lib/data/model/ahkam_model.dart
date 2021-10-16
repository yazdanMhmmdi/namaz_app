class AhkamModel {
  List<Ahkam> ahkam;
  String error;
  String errorMessage;
  Data data;
  Marjae marjae;

  AhkamModel(
      {this.ahkam, this.error, this.errorMessage, this.data, this.marjae});

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
    marjae =
        json['marjae'] != null ? new Marjae.fromJson(json['marjae']) : null;
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
    if (this.marjae != null) {
      data['marjae'] = this.marjae.toJson();
    }
    return data;
  }
}

class Ahkam {
  String id;
  String marjaeId;
  String title;
  String ahkamNumber;

  Ahkam({this.id, this.marjaeId, this.title, this.ahkamNumber});

  Ahkam.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    marjaeId = json['marjae_id'];
    title = json['title'];
    ahkamNumber = json['ahkam_number'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['marjae_id'] = this.marjaeId;
    data['title'] = this.title;
    data['ahkam_number'] = this.ahkamNumber;
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

class Marjae {
  String name;
  String pictureSizeSmall;
  String blurhash;

  Marjae({this.name, this.pictureSizeSmall, this.blurhash});

  Marjae.fromJson(Map<String, dynamic> json) {
    name = json['name'];
    pictureSizeSmall = json['picture_size_small'];
    blurhash = json['blurhash'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['name'] = this.name;
    data['picture_size_small'] = this.pictureSizeSmall;
    data['blurhash'] = this.blurhash;
    return data;
  }
}
