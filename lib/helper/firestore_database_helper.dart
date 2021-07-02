import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:search_islam/data/model/comment_feedback_models.dart';
import 'package:search_islam/data/model/comment_models.dart';
import 'package:search_islam/data/model/janun_model.dart';
import 'package:search_islam/data/model/name_model.dart';
import 'package:search_islam/utill/app_constants.dart';

final collectionComment = 'comments';
final collectionReply = 'reply';
final phophet = 'prophet';
final islamicResourceKnowledge = 'islamic_resource_knowledge';
final nosihat = 'nosihat';

class FirestoreDatabaseHelper {
  static final FirebaseFirestore db = FirebaseFirestore.instance;

  // for Nosihat section:
  static Future addNosihatToFirebase(JanunModelNosihat janunModel, int id) async {
    return db.collection(nosihat).doc(id.toString()).collection(nosihat).doc(janunModel.id.toString()).set(janunModel.tomap());
  }

  // ignore: missing_return
  static Future<List<JanunModelNosihat>> nosihatList(int id) async {
    QuerySnapshot snapshot = await db.collection(nosihat).doc(id.toString()).collection(nosihat).get();
    if (snapshot != null) {
      return snapshot.docs.map((e) => JanunModelNosihat.fromMap(e.data())).toList();
    }
  }

  // for janun section:
  static Future addJanunToFirebase(JanunModel janunModel, {bool isProphet = true}) async {
    return db.collection(isProphet ? phophet : islamicResourceKnowledge).doc(janunModel.id.toString()).set(janunModel.tomap());
  }

  // ignore: missing_return
  static Future<List<JanunModel>> janunLists({bool isProphet = true}) async {
    QuerySnapshot snapshot = await db.collection(isProphet ? phophet : islamicResourceKnowledge).get();
    if (snapshot != null) {
      return snapshot.docs.map((e) => JanunModel.fromMap(e.data())).toList();
    }
  }

  // add person Name

  static Future addNameToFirebase(NameModel nameModel) async {
    return db.collection(AppConstants.PERSON_NAME).doc(nameModel.category.toString()).collection('sl_no').doc(nameModel.slNo).set(nameModel.toMap());
  }

  // ignore: missing_return
  static Future<List<NameModel>> nameLists(int categoryId) async {
    QuerySnapshot snapshot = await db.collection(AppConstants.PERSON_NAME).doc(categoryId.toString()).collection('sl_no').get();
    if (snapshot != null) {
      return snapshot.docs.map((e) => NameModel.fromMap(e.data())).toList();
    }
  }

  static Future addComment(CommentModels commentModels) async {
    final doc = db.collection(collectionComment).doc(commentModels.id);
    return await doc.set(commentModels.tomap());
  }

  static Future updateFeedBack(CommentModels commentModels) async {
    return db.collection(collectionComment).doc(commentModels.id).update(commentModels.tomap());
  }

  static Future addFeedBack(ComentFeedBackModels comentFeedBackModels) async {
    final doc = db.collection(collectionReply).doc(comentFeedBackModels.id).collection('reply').doc(comentFeedBackModels.dateKey);
    return await doc.set(comentFeedBackModels.tomap());
  }

// ignore: missing_return
  static Future<List<CommentModels>> getAllCommentModels() async {
    QuerySnapshot snapshot = await db.collection(collectionComment).get();
    if (snapshot != null) {
      return snapshot.docs.map((e) => CommentModels.fromMap(e.data())).toList();
    }
  }

// ignore: missing_return
  static Future<List<ComentFeedBackModels>> getAllReplySpecifyQuestion(String id) async {
    QuerySnapshot snapshot = await db.collection(collectionReply).doc(id).collection('reply').get();
    if (snapshot != null) {
      return snapshot.docs.map((e) => ComentFeedBackModels.fromMap(e.data())).toList();
    }
  }
}
