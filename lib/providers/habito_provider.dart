import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_aula_1/models/habito.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:uuid/uuid.dart';

class HabitoProvider with ChangeNotifier {
  final List<Habito> _habitos = [];
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;
  final String _collection = 'habitos';

  List<Habito> get habitos => [..._habitos];

  Future<void> fetchHabitos() async {
    final user = FirebaseAuth.instance.currentUser;
    if (user == null) {
      _habitos.clear();
      notifyListeners();
      return;
    }

    final snapshot =
        await _firestore
            .collection(_collection)
            .where('userId', isEqualTo: user.uid)
            .get();

    _habitos.clear();
    _habitos.addAll(
      snapshot.docs.map(
        (doc) => Habito.fromMap(doc.data() as Map<String, dynamic>),
      ),
    );
    notifyListeners();
  }

  Future<void> addHabito({
    required String name,
    required String frequency,
    TimeOfDay? reminderTime,
  }) async {
    final user = FirebaseAuth.instance.currentUser;
    if (user == null) {
      throw Exception('Usuário não autenticado');
    }

    final id = const Uuid().v4();
    final newHabito = Habito(
      id: id,
      userId: user.uid, // salva o uid do usuário
      name: name,
      frequency: frequency,
      reminderTime: reminderTime,
    );

    await _firestore.collection(_collection).doc(id).set(newHabito.toMap());
    _habitos.add(newHabito);
    notifyListeners();
  }

  Future<void> editHabito(
    String id, {
    required String name,
    required String frequency,
    TimeOfDay? remindertime,
  }) async {
    final index = _habitos.indexWhere((habito) => habito.id == id);
    if (index >= 0) {
      final updated =
          _habitos[index]
            ..name = name
            ..frequency = frequency
            ..reminderTime = remindertime;

      await _firestore.collection(_collection).doc(id).update(updated.toMap());
      notifyListeners();
    }
  }

  Future<void> deleteHabito(String id) async {
    await _firestore.collection(_collection).doc(id).delete();
    _habitos.removeWhere((habito) => habito.id == id);
    notifyListeners();
  }

  Future<void> completeHabito(String id) async {
    final habito = _habitos.firstWhere((habito) => habito.id == id);
    habito.completeToday();
    await _firestore.collection(_collection).doc(id).update(habito.toMap());
    notifyListeners();
  }

  Future<void> undoHabito(String id) async {
    final habito = _habitos.firstWhere((habito) => habito.id == id);
    habito.undoToday();
    await _firestore.collection(_collection).doc(id).update(habito.toMap());
    notifyListeners();
  }

  Habito getHabitoById(String id) {
    return _habitos.firstWhere((habito) => habito.id == id);
  }
}
