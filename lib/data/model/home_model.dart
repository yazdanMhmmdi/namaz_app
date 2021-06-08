class HomeModel {
  String error;
  String errorMessage;
  List<Marjae> marjae;
  List<Narratives> narratives;
  List<ShohadaBozorgan> shohadaBozorgan;
  Video video;

  HomeModel(
      {this.error,
      this.errorMessage,
      this.marjae,
      this.narratives,
      this.shohadaBozorgan,
      this.video});

  HomeModel.fromJson(Map<String, dynamic> json) {
    error = json['error'];
    errorMessage = json['error_message'];
    if (json['marjae'] != null) {
      marjae = new List<Marjae>();
      json['marjae'].forEach((v) {
        marjae.add(new Marjae.fromJson(v));
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
    video = json['video'] != null ? new Video.fromJson(json['video']) : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['error'] = this.error;
    data['error_message'] = this.errorMessage;
    if (this.marjae != null) {
      data['marjae'] = this.marjae.map((v) => v.toJson()).toList();
    }
    if (this.narratives != null) {
      data['narratives'] = this.narratives.map((v) => v.toJson()).toList();
    }
    if (this.shohadaBozorgan != null) {
      data['shohada_bozorgan'] =
          this.shohadaBozorgan.map((v) => v.toJson()).toList();
    }
    if (this.video != null) {
      data['video'] = this.video.toJson();
    }
    return data;
  }
}

class Marjae {
  String s0;
  String s1;
  String s2;
  String s3;
  String id;
  String name;
  String pictureSizeSmall;
  String pictureSizeLarge;

  Marjae(
      {this.s0,
      this.s1,
      this.s2,
      this.s3,
      this.id,
      this.name,
      this.pictureSizeSmall,
      this.pictureSizeLarge});

  Marjae.fromJson(Map<String, dynamic> json) {
    s0 = json['0'];
    s1 = json['1'];
    s2 = json['2'];
    s3 = json['3'];
    id = json['id'];
    name = json['name'];
    pictureSizeSmall = json['picture_size_small'];
    pictureSizeLarge = json['picture_size_large'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['0'] = this.s0;
    data['1'] = this.s1;
    data['2'] = this.s2;
    data['3'] = this.s3;
    data['id'] = this.id;
    data['name'] = this.name;
    data['picture_size_small'] = this.pictureSizeSmall;
    data['picture_size_large'] = this.pictureSizeLarge;
    return data;
  }
}

class Narratives {
  String s0;
  String s1;
  String s2;
  String s3;
  String s4;
  String s5;
  String s6;
  String rowid;
  String id;
  String quotee;
  String quote;
  String quoteeTranslation;
  String quoteTranslation;
  String source;

  Narratives(
      {this.s0,
      this.s1,
      this.s2,
      this.s3,
      this.s4,
      this.s5,
      this.s6,
      this.rowid,
      this.id,
      this.quotee,
      this.quote,
      this.quoteeTranslation,
      this.quoteTranslation,
      this.source});

  Narratives.fromJson(Map<String, dynamic> json) {
    s0 = json['0'];
    s1 = json['1'];
    s2 = json['2'];
    s3 = json['3'];
    s4 = json['4'];
    s5 = json['5'];
    s6 = json['6'];
    rowid = json['rowid'];
    id = json['id'];
    quotee = json['quotee'];
    quote = json['quote'];
    quoteeTranslation = json['quoteeTranslation'];
    quoteTranslation = json['quoteTranslation'];
    source = json['source'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['0'] = this.s0;
    data['1'] = this.s1;
    data['2'] = this.s2;
    data['3'] = this.s3;
    data['4'] = this.s4;
    data['5'] = this.s5;
    data['6'] = this.s6;
    data['rowid'] = this.rowid;
    data['id'] = this.id;
    data['quotee'] = this.quotee;
    data['quote'] = this.quote;
    data['quoteeTranslation'] = this.quoteeTranslation;
    data['quoteTranslation'] = this.quoteTranslation;
    data['source'] = this.source;
    return data;
  }
}

class ShohadaBozorgan {
  String s0;
  String s1;
  String s2;
  String s3;
  String s4;
  String id;
  String name;
  String pictureSizeSmall;
  String pictureSizeLarge;
  String titleText;

  ShohadaBozorgan(
      {this.s0,
      this.s1,
      this.s2,
      this.s3,
      this.s4,
      this.id,
      this.name,
      this.pictureSizeSmall,
      this.pictureSizeLarge,
      this.titleText});

  ShohadaBozorgan.fromJson(Map<String, dynamic> json) {
    s0 = json['0'];
    s1 = json['1'];
    s2 = json['2'];
    s3 = json['3'];
    s4 = json['4'];
    id = json['id'];
    name = json['name'];
    pictureSizeSmall = json['picture_size_small'];
    pictureSizeLarge = json['picture_size_large'];
    titleText = json['title_text'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['0'] = this.s0;
    data['1'] = this.s1;
    data['2'] = this.s2;
    data['3'] = this.s3;
    data['4'] = this.s4;
    data['id'] = this.id;
    data['name'] = this.name;
    data['picture_size_small'] = this.pictureSizeSmall;
    data['picture_size_large'] = this.pictureSizeLarge;
    data['title_text'] = this.titleText;
    return data;
  }
}

class Video {
  String s0;
  String s1;
  String s2;
  String s3;
  String id;
  String thumbnail;
  String video;
  String title;

  Video(
      {this.s0,
      this.s1,
      this.s2,
      this.s3,
      this.id,
      this.thumbnail,
      this.video,
      this.title});

  Video.fromJson(Map<String, dynamic> json) {
    s0 = json['0'];
    s1 = json['1'];
    s2 = json['2'];
    s3 = json['3'];
    id = json['id'];
    thumbnail = json['thumbnail'];
    video = json['video'];
    title = json['title'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['0'] = this.s0;
    data['1'] = this.s1;
    data['2'] = this.s2;
    data['3'] = this.s3;
    data['id'] = this.id;
    data['thumbnail'] = this.thumbnail;
    data['video'] = this.video;
    data['title'] = this.title;
    return data;
  }
}
