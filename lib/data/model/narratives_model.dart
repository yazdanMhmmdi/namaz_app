class NarrativesModel {
  List<Narratives> narratives;
  String error;
  String errorMessage;
  Data data;

  NarrativesModel({this.narratives, this.error, this.errorMessage, this.data});

  NarrativesModel.fromJson(Map<String, dynamic> json) {
    if (json['narratives'] != null) {
      narratives = new List<Narratives>();
      json['narratives'].forEach((v) {
        narratives.add(new Narratives.fromJson(v));
      });
    }
    error = json['error'];
    errorMessage = json['error_message'];
    data = json['data'] != null ? new Data.fromJson(json['data']) : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    if (this.narratives != null) {
      data['narratives'] = this.narratives.map((v) => v.toJson()).toList();
    }
    data['error'] = this.error;
    data['error_message'] = this.errorMessage;
    if (this.data != null) {
      data['data'] = this.data.toJson();
    }
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
