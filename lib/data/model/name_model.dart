class NameModel{
  String slNo;
  String title;
  String meaning;
  int category;
  String updateName;

  NameModel(this.slNo, this.title, this.meaning, this.category, {this.updateName='shuvo'});

  Map<String,dynamic> toMap(){
    final map=<String,dynamic>{
      'slNo':slNo,
      'category':category,
      'title':title,
      'meaning':meaning,
    };
    return map;
  }

  NameModel.fromMap(Map<String,dynamic> map){
    slNo=map['slNo'];
    category=map['category'];
    title=map['title'];
    meaning=map['meaning'];
  }

}