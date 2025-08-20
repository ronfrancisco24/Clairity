import 'package:cloud_firestore/cloud_firestore.dart';
import '../models/cleaning_log_model.dart';

class LogRecordsService {
  final _firestore = FirebaseFirestore.instance;
  final _collection = 'cleaning_records';

  Future<List<CleaningRecord>> fetchLogs() async {
    final snapshot = await _firestore.collection(_collection).get();
    return snapshot.docs
        .map((doc) => CleaningRecord.fromFirestore(doc.data(), doc.id))
        .toList();
  }

  Stream<CleaningRecord> fetchLastCleanedTime(String sensorId) {
    return _firestore
        .collection('cleaning_records')
        .orderBy('timestamp', descending: true)
        .where('sensorId', isEqualTo: sensorId)
        .limit(1)
        .snapshots()
        .map((snapshot) {
      final doc = snapshot.docs.first;
      return CleaningRecord.fromFirestore(doc.data(), doc.id);
    });
  }

  Future<CleaningRecord> addLog(CleaningRecord record) async {
    final docRef = await _firestore.collection(_collection).add(record.toFirestore());
    return record.copyWith(cleaningId: docRef.id);
  }

  Future<void> editLog(CleaningRecord updatedRecord) async {
    await _firestore
        .collection(_collection)
        .doc(updatedRecord.cleaningId)
        .update(updatedRecord.toFirestore());
  }

  Future<void> updateLog(String cleaningId,
      {required bool acknowledged, required String adminMessage}) async {
    await _firestore.collection(_collection).doc(cleaningId).update({
      'acknowledged': acknowledged,
      'adminMessage': adminMessage,
    });
  }

  Future<void> removeLog(String cleaningId) async {
    await _firestore.collection(_collection).doc(cleaningId).delete();
  }
}
