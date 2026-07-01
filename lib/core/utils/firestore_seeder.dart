import 'dart:convert';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/services.dart';
import 'package:flutter/foundation.dart';

import 'package:lex_core/di/injection_container.dart';

class FirestoreSeeder {
  static FirebaseFirestore get _firestore => sl<FirebaseFirestore>();

  static Future<void> seedAll() async {
    if (!kDebugMode) {
      print('Seeding is only allowed in debug mode.');
      return;
    }
    
    print('Starting Firestore seed...');
    await seedCollection('assets/seed_data/users.json', 'users');
    await seedCollection('assets/seed_data/lawyers.json', 'lawyers');
    await seedCollection('assets/seed_data/students.json', 'students');
    await seedCollection('assets/seed_data/cases.json', 'cases');
    await seedCollection('assets/seed_data/certifications.json', 'certifications');
    print('Firestore seed complete!');
  }

  static Future<void> seedCollection(String assetPath, String collectionName) async {
    try {
      final jsonString = await rootBundle.loadString(assetPath);
      final Map<String, dynamic> jsonData = jsonDecode(jsonString);
      
      final batch = _firestore.batch();
      
      jsonData.forEach((key, value) {
        final docRef = _firestore.collection(collectionName).doc(key);
        batch.set(docRef, value, SetOptions(merge: true));
      });
      
      await batch.commit();
      print('Successfully seeded $collectionName from $assetPath');
    } catch (e) {
      print('Error seeding $collectionName: $e');
    }
  }
}
