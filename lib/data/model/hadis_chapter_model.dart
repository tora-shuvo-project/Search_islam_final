class HadisChapterModel {
  int bookId;
  String hadisRange;
  int id;
  int number;
  String title;

  HadisChapterModel(
      {this.bookId, this.hadisRange, this.id, this.number, this.title});

  HadisChapterModel.fromJson(Map<String, dynamic> json) {
    bookId = json['book_id'];
    hadisRange = json['hadis_range'];
    id = json['id'];
    number = json['number'];
    title = json['title'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['book_id'] = this.bookId;
    data['hadis_range'] = this.hadisRange;
    data['id'] = this.id;
    data['number'] = this.number;
    data['title'] = this.title;
    return data;
  }
}
