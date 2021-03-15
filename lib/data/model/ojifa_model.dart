class OjifaModel {
  int topicNo, subtopicNo;
  String name, araby, banglaMeaning, banglaTranslator, fozilot, niyom;

  OjifaModel({this.topicNo, this.subtopicNo, this.name, this.araby, this.banglaMeaning, this.banglaTranslator, this.fozilot, this.niyom});

  OjifaModel.fromMap(dynamic map) {
    this.topicNo = map['TOPICNO'];
    this.subtopicNo = map['SUBTOPICNO'];
    this.name = map['NAME'];
    this.araby = map['ARABI'];
    this.banglaMeaning = map['BANGLAMEANING'];
    this.banglaTranslator = map['BANGLATRANSLATOR'];
    this.fozilot = map['FOZILOT'];
    this.niyom = map['NIYOM'];
  }
}
