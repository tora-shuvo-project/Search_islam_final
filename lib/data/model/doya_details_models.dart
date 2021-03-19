class DoyaDetailsModels {
  int slNo, globalId;
  String id, arabic, banglaMeaning, banglaTranslator, niyom, reference;

  DoyaDetailsModels({this.id, this.slNo, this.globalId, this.arabic, this.banglaMeaning, this.banglaTranslator, this.niyom, this.reference});

  DoyaDetailsModels.fromMap(dynamic map) {
    this.id = map['ID'];
    this.slNo = map['SL_NO'];
    this.globalId = map['GLOBAL_ID'];
    this.arabic = map['ARABIC'];
    this.banglaMeaning = map['BANGLA_MEANING'];
    this.banglaTranslator = map['BANGLA_TRANSLATOR'];
    this.niyom = map['NIYOM'];
    this.reference = map['REFERENCE'];
  }
}
