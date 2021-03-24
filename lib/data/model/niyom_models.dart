class NiyomModel{
  int category,sub_category;
  String name,description;

  NiyomModel(this.category, this.sub_category, this.name, this.description);

  NiyomModel.fromMap(dynamic map){
    this.category=map['CATEGORY'];
    this.sub_category=map['SUB_CATEGORY'];
    this.name=map['NAME'];
    this.description=map['DESCRIPTIONN'];
  }
}