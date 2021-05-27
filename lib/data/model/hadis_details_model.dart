class HadisDetailsModel {
  String content;
  String footnote;
  int id;
  String narrator;

  HadisDetailsModel({this.content, this.footnote, this.id, this.narrator});

  HadisDetailsModel.fromJson(Map<String, dynamic> json) {
    content = json['content'];
    footnote = json['footnote'];
    id = json['id'];
    narrator = json['narrator'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['content'] = this.content;
    data['footnote'] = this.footnote;
    data['id'] = this.id;
    data['narrator'] = this.narrator;
    return data;
  }
}
