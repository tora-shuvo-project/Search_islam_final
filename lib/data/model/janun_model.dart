class JanunModel {
  int id;
  String title;
  String description;

  JanunModel({this.id, this.title, this.description});

  Map<String, dynamic> tomap() {
    final map = <String, dynamic>{
      'id': id,
      'title': title,
      'description': description,
    };
    return map;
  }

  JanunModel.fromMap(Map<String, dynamic> map) {
    id = map['id'];
    title = map['title'];
    description = map['description'];
  }
}

class JanunModelNosihat {
  int id;
  String title;
  String reference;

  JanunModelNosihat({this.id, this.title, this.reference});

  Map<String, dynamic> tomap() {
    final map = <String, dynamic>{
      'id': id,
      'title': title,
      'reference': reference,
    };
    return map;
  }

  JanunModelNosihat.fromMap(Map<String, dynamic> map) {
    id = map['id'];
    title = map['title'];
    reference = map['reference'];
  }
}
