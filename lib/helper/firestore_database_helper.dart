import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:search_islam/data/model/name_model.dart';
import 'package:search_islam/utill/app_constants.dart';

// final COLLECTION_COMMENT='comments';
// final COLLECTION_REPLY='reply';

class FirestoreDatabaseHelper {
  static final FirebaseFirestore db = FirebaseFirestore.instance;

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

// static Future addComment(CommentModels commentModels)async{
//   final doc=db.collection(COLLECTION_COMMENT).document(commentModels.id);
//   return await doc.setData(commentModels.tomap());
// }
// static Future UpdateFeedBack(CommentModels commentModels)async{
//   return db.collection(COLLECTION_COMMENT).document(commentModels.id).updateData(commentModels.tomap());
// }
//
// static Future addFeedBack(ComentFeedBackModels comentFeedBackModels)async{
//   final doc=db.collection(COLLECTION_REPLY).document(comentFeedBackModels.id).collection('reply').document(comentFeedBackModels.dateKey);
//   return await doc.setData(comentFeedBackModels.tomap());
// }
//
// static Future<List<CommentModels>> getAllCommentModels()async{
//   QuerySnapshot snapshot=await db.collection(COLLECTION_COMMENT).getDocuments();
//   if(snapshot!=null){
//     return snapshot.documents.map((e) => CommentModels.fromMap(e.data)).toList();
//   }
// }
//
// static Future<List<ComentFeedBackModels>> getAllReplySpecifyQuestion(String id)async{
//   QuerySnapshot snapshot=await db.collection(COLLECTION_REPLY).document(id).collection('reply').getDocuments();
//   if(snapshot!=null){
//     return snapshot.documents.map((e) => ComentFeedBackModels.fromMap(e.data)).toList();
//   }
// }

}
