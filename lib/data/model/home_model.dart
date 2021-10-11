class HomeModel {
  String error;
  String errorMessage;
  List<Marjae> marjae;
  List<Narratives> narratives;
  List<ShohadaBozorgan> shohadaBozorgan;
  Video video;
  LiveTv liveTv;

  HomeModel(
      {this.error,
      this.errorMessage,
      this.marjae,
      this.narratives,
      this.shohadaBozorgan,
      this.video,
      this.liveTv});

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
    liveTv =
        json['live_tv'] != null ? new LiveTv.fromJson(json['live_tv']) : null;
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
    if (this.liveTv != null) {
      data['live_tv'] = this.liveTv.toJson();
    }
    return data;
  }
}

class Marjae {
  String id;
  String name;
  String pictureSizeSmall;
  String pictureSizeLarge;
  String pictureSizeXLarge;
  String blurhash;

  Marjae(
      {this.id,
      this.name,
      this.pictureSizeSmall,
      this.pictureSizeLarge,
      this.pictureSizeXLarge,
      this.blurhash});

  Marjae.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    name = json['name'];
    pictureSizeSmall = json['picture_size_small'];
    pictureSizeLarge = json['picture_size_large'];
    pictureSizeXLarge = json['picture_size_x_large'];
    blurhash = json['blurhash'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['name'] = this.name;
    data['picture_size_small'] = this.pictureSizeSmall;
    data['picture_size_large'] = this.pictureSizeLarge;
    data['picture_size_x_large'] = this.pictureSizeXLarge;
    data['blurhash'] = this.blurhash;
    return data;
  }
}

class Narratives {
  String rowid;
  String id;
  String quotee;
  String quote;
  String quoteeTranslation;
  String quoteTranslation;
  String source;

  Narratives(
      {this.rowid,
      this.id,
      this.quotee,
      this.quote,
      this.quoteeTranslation,
      this.quoteTranslation,
      this.source});

  Narratives.fromJson(Map<String, dynamic> json) {
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
  String id;
  String name;
  String pictureSizeSmall;
  String pictureSizeLarge;
  String pictureSizeXLarge;
  String titleText;
  String blurhash;
  String homeOrderNumber;

  ShohadaBozorgan(
      {this.id,
      this.name,
      this.pictureSizeSmall,
      this.pictureSizeLarge,
      this.pictureSizeXLarge,
      this.titleText,
      this.blurhash,
      this.homeOrderNumber});

  ShohadaBozorgan.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    name = json['name'];
    pictureSizeSmall = json['picture_size_small'];
    pictureSizeLarge = json['picture_size_large'];
    pictureSizeXLarge = json['picture_size_x_large'];
    titleText = json['title_text'];
    blurhash = json['blurhash'];
    homeOrderNumber = json['home_order_number'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['name'] = this.name;
    data['picture_size_small'] = this.pictureSizeSmall;
    data['picture_size_large'] = this.pictureSizeLarge;
    data['picture_size_x_large'] = this.pictureSizeXLarge;
    data['title_text'] = this.titleText;
    data['blurhash'] = this.blurhash;
    data['home_order_number'] = this.homeOrderNumber;
    return data;
  }
}

class Video {
  String id;
  String thumbnail;
  String video;
  String title;
  String blurhash;
  String orderNumber;
  String isPinned;

  Video(
      {this.id,
      this.thumbnail,
      this.video,
      this.title,
      this.blurhash,
      this.orderNumber,
      this.isPinned});

  Video.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    thumbnail = json['thumbnail'];
    video = json['video'];
    title = json['title'];
    blurhash = json['blurhash'];
    orderNumber = json['order_number'];
    isPinned = json['is_pinned'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['thumbnail'] = this.thumbnail;
    data['video'] = this.video;
    data['title'] = this.title;
    data['blurhash'] = this.blurhash;
    data['order_number'] = this.orderNumber;
    data['is_pinned'] = this.isPinned;
    return data;
  }
}

class LiveTv {
  String id;
  String name;
  String stream;
  String thumbPicture;
  String blurhash;
  String orderNumber;

  LiveTv(
      {this.id,
      this.name,
      this.stream,
      this.thumbPicture,
      this.blurhash,
      this.orderNumber});

  LiveTv.fromJson(Map<String, dynamic> json) {
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
