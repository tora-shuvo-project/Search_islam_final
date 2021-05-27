class NiyomModel{
  int category,subCategory;
  String name,description;

  NiyomModel(this.category, this.subCategory, this.name, this.description);

  NiyomModel.fromMap(dynamic map){
    this.category=map['CATEGORY'];
    this.subCategory=map['SUB_CATEGORY'];
    this.name=map['NAME'];
    this.description=map['DESCRIPTIONN'];
  }
}