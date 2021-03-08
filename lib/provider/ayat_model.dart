class AyatModel {
  String arabicSimple;
  String arabicUtmanic;
  String arabicIndopak;
  String banglaMeaning;
  String banglaTranslator;
  String sejda;
  String ayatAudio;
  int ayatno;
  int surano;
  int para;

  AyatModel(
      {this.arabicSimple,
      this.arabicUtmanic,
      this.arabicIndopak,
      this.banglaMeaning,
      this.banglaTranslator,
      this.sejda,
      this.ayatAudio,
      this.ayatno,
      this.surano,
      this.para});

  // ignore: missing_return
  Map<String, dynamic> tomap() {
    var map = new Map<String, dynamic>();
    map['AYATNO'] = ayatno;
    map['SURANO'] = surano;
    map['ARABI_SIMPLE'] = arabicSimple;
    map['ARABI_UTMANIC'] = arabicUtmanic;
    map['ARABI_INDOPAK'] = arabicIndopak;
    map['BANGLA_MUHI'] = banglaMeaning;
    map['BANGLA_TRANSLATOR'] = banglaTranslator;
    map['SEJDA'] = sejda;
    map['PARA'] = para;
    map['AYATAUDIO'] = ayatAudio;
  }

  AyatModel.formMap(dynamic map) {
    this.ayatno = map['AYATNO'];
    this.surano = map['SURANO'];
    this.arabicSimple = map['ARABI_SIMPLE'];
    this.arabicUtmanic = map['ARABI_UTMANIC'];
    this.arabicIndopak = map['ARABI_INDOPAK'];
    this.banglaMeaning = map['BANGLA_MUHI'];
    this.banglaTranslator = map['BANGLA_TRANSLATOR'];
    this.sejda = map['SEJDA'];
    this.ayatAudio = map['AYATAUDIO'];
    this.para = map['PARA'];
  }
}
