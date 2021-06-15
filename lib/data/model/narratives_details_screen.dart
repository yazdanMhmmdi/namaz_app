class NarrativesDetailsModel {
  String error;
  String errorMessage;
  Data data;

  NarrativesDetailsModel({this.error, this.errorMessage, this.data});

  NarrativesDetailsModel.fromJson(Map<String, dynamic> json) {
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
  String rowid;
  String id;
  String quotee;
  String quote;
  String quoteeTranslation;
  String quoteTranslation;
  String source;

  Data(
      {this.rowid,
      this.id,
      this.quotee,
      this.quote,
      this.quoteeTranslation,
      this.quoteTranslation,
      this.source});

  Data.fromJson(Map<String, dynamic> json) {
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
