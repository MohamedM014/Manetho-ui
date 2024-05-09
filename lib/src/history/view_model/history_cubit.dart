import 'package:bloc/bloc.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:mannetho/core/constants/constants.dart';
import 'package:meta/meta.dart';

part 'history_state.dart';

class HistoryCubit extends Cubit<HistoryState> {
  HistoryCubit() : super(HistoryInitial());


  Query historyQuery= FirebaseFirestore.instance
      .collection(AppConstants.historyCollection)
      .where('userId', isEqualTo: FirebaseAuth.instance.currentUser!.uid)
  .orderBy('createdAt', descending: true);



  Future<void> deleteHistoryItem(String itemId)async {
    await FirebaseFirestore.instance
        .collection(AppConstants.historyCollection)
        .doc(itemId).delete()
        .catchError((error){});
  }

  bool loadWhileDeleting= false;
  Future<void> deleteAllHistory()async {

    final instance = FirebaseFirestore.instance;
    final batch = instance.batch();
    var collection = instance.collection(AppConstants.historyCollection)
        .where('userId', isEqualTo: FirebaseAuth.instance.currentUser!.uid);
    var snapshots = await collection.get();
    for (var doc in snapshots.docs) {
      batch.delete(doc.reference);
    }
    await batch.commit();

    // loadWhileDeleting= true;
    // await FirebaseFirestore.instance
    //     .collection(AppConstants.historyCollection)
    //     .doc(FirebaseAuth.instance.currentUser!.uid)
    //     .delete()
    //     .catchError((error){
    //   loadWhileDeleting= false;
    // });
  }
}
