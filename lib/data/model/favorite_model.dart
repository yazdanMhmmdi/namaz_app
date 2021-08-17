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
  String title;
  String ahkamNumber;

  Ahkam({this.id, this.ahkamId, this.userId, this.title, this.ahkamNumber});

  Ahkam.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    ahkamId = json['ahkam_id'];
    userId = json['user_id'];
    title = json['title'];
    ahkamNumber = json['ahkam_number'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['ahkam_id'] = this.ahkamId;
    data['user_id'] = this.userId;
    data['title'] = this.title;
    data['ahkam_number'] = this.ahkamNumber;
    return data;
  }
}

class Narratives {
  String id;
  String narrativesId;
  String userId;
  String quoteeTranslation;
  String quoteTranslation;

  Narratives(
      {this.id,
      this.narrativesId,
      this.userId,
      this.quoteeTranslation,
      this.quoteTranslation});

  Narratives.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    narrativesId = json['narratives_id'];
    userId = json['user_id'];
    quoteeTranslation = json['quoteeTranslation'];
    quoteTranslation = json['quoteTranslation'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['narratives_id'] = this.narrativesId;
    data['user_id'] = this.userId;
    data['quoteeTranslation'] = this.quoteeTranslation;
    data['quoteTranslation'] = this.quoteTranslation;
    return data;
  }
}

class ShohadaBozorgan {
  String id;
  String shohadaBozorganId;
  String userId;
  String pictureSizeLarge;
  String name;
  String blurhash;

  ShohadaBozorgan(
      {this.id,
      this.shohadaBozorganId,
      this.userId,
      this.pictureSizeLarge,
      this.name,
      this.blurhash});

  ShohadaBozorgan.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    shohadaBozorganId = json['shohada_bozorgan_id'];
    userId = json['user_id'];
    pictureSizeLarge = json['picture_size_large'];
    name = json['name'];
    blurhash = json['blurhash'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['shohada_bozorgan_id'] = this.shohadaBozorganId;
    data['user_id'] = this.userId;
    data['picture_size_large'] = this.pictureSizeLarge;
    data['name'] = this.name;
    data['blurhash'] = this.blurhash;
    return data;
  }
}

class Video {
  String id;
  String userId;
  String videoId;
  String thumbnail;
  String title;
  String video;
  String blurhash;

  Video(
      {this.id,
      this.userId,
      this.videoId,
      this.thumbnail,
      this.title,
      this.video,
      this.blurhash});

  Video.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    userId = json['user_id'];
    videoId = json['video_id'];
    thumbnail = json['thumbnail'];
    title = json['title'];
    video = json['video'];
    blurhash = json['blurhash'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['user_id'] = this.userId;
    data['video_id'] = this.videoId;
    data['thumbnail'] = this.thumbnail;
    data['title'] = this.title;
    data['video'] = this.video;
    data['blurhash'] = this.blurhash;
    return data;
  }
}
