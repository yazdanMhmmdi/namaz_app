class FavoriteModel {
  String error;
  String errorMessage;
  List<Ahkam> ahkam;
  List<Narratives> narratives;
  List<ShohadaBozorgan> shohadaBozorgan;
  List<Video> video;

  FavoriteModel(
      {this.error,
      this.errorMessage,
      this.ahkam,
      this.narratives,
      this.shohadaBozorgan,
      this.video});

  FavoriteModel.fromJson(Map<String, dynamic> json) {
    error = json['error'];
    errorMessage = json['error_message'];
    if (json['ahkam'] != null) {
      ahkam = new List<Ahkam>();
      json['ahkam'].forEach((v) {
        ahkam.add(new Ahkam.fromJson(v));
      });
    }
    if (json['narratives'] != null) {
      narratives = new List<Narratives>();
      json['narratives'].forEach((v) {
        narratives.add(new Narratives.fromJson(v));
      });
    }
    if (json['shohada_bozorgan'] != null) {
      shohadaBozorgan = new List<ShohadaBozorgan>();
      json['shohada_bozorgan'].forEach((v) {
        shohadaBozorgan.add(new ShohadaBozorgan.fromJson(v));
      });
    }
    if (json['video'] != null) {
      video = new List<Video>();
      json['video'].forEach((v) {
        video.add(new Video.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['error'] = this.error;
    data['error_message'] = this.errorMessage;
    if (this.ahkam != null) {
      data['ahkam'] = this.ahkam.map((v) => v.toJson()).toList();
    }
    if (this.narratives != null) {
      data['narratives'] = this.narratives.map((v) => v.toJson()).toList();
    }
    if (this.shohadaBozorgan != null) {
      data['shohada_bozorgan'] =
          this.shohadaBozorgan.map((v) => v.toJson()).toList();
    }
    if (this.video != null) {
      data['video'] = this.video.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class Ahkam {
  String id;
  String ahkamId;
  String userId;

  Ahkam({this.id, this.ahkamId, this.userId});

  Ahkam.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    ahkamId = json['ahkam_id'];
    userId = json['user_id'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['ahkam_id'] = this.ahkamId;
    data['user_id'] = this.userId;
    return data;
  }
}

class Narratives {
  String id;
  String narrativesId;
  String userId;

  Narratives({this.id, this.narrativesId, this.userId});

  Narratives.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    narrativesId = json['narratives_id'];
    userId = json['user_id'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['narratives_id'] = this.narrativesId;
    data['user_id'] = this.userId;
    return data;
  }
}

class ShohadaBozorgan {
  String id;
  String shohadaBozorganId;
  String userId;

  ShohadaBozorgan({this.id, this.shohadaBozorganId, this.userId});

  ShohadaBozorgan.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    shohadaBozorganId = json['shohada_bozorgan_id'];
    userId = json['user_id'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['shohada_bozorgan_id'] = this.shohadaBozorganId;
    data['user_id'] = this.userId;
    return data;
  }
}

class Video {
  String id;
  String userId;
  String videoId;

  Video({this.id, this.userId, this.videoId});

  Video.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    userId = json['user_id'];
    videoId = json['video_id'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['user_id'] = this.userId;
    data['video_id'] = this.videoId;
    return data;
  }
}
