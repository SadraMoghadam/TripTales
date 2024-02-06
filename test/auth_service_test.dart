import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';
import 'package:trip_tales/src/services/auth_service.dart';
import 'package:trip_tales/src/utils/app_manager.dart';

// Mocking Firebase classes
class MockFirebaseAuth extends Mock implements FirebaseAuth {}

class MockFirebaseStorage extends Mock implements FirebaseStorage {}

class MockFirestore extends Mock implements FirebaseFirestore {}

class MockAppManager extends Mock implements AppManager {}

// void main() {
//   group('AuthService', () {
//     late MockFirebaseAuth mockFirebaseAuth;
//     late MockFirebaseStorage mockFirebaseStorage;
//     late MockFirestore mockFirestore;
//     late MockAppManager mockAppManager;
//     late AuthService authService;
//
//     setUp(() {
//       mockFirebaseAuth = MockFirebaseAuth();
//       mockFirebaseStorage = MockFirebaseStorage();
//       mockFirestore = MockFirestore();
//       mockAppManager = MockAppManager();
//
//       authService = AuthService();
//       // authService._auth = mockFirebaseAuth;
//       // authService._storage = mockFirebaseStorage;
//       // authService._firestore = mockFirestore;
//       // authService._appManager = mockAppManager;
//     });
//
//     test('signInWithGoogle should sign in with Google', () async {
//       // Arrange
//       final mockedUser = User();
//       when(mockFirebaseAuth.signInWithCredential(any))
//           .thenAnswer((_) async => UserCredential(user: mockedUser));
//       when(mockFirebaseAuth.authStateChanges()).thenAnswer((_) =>
//           Stream.fromIterable([null, mockedUser])); // Simulate auth changes
//
//       // Act
//       final result = await authService.signInWithGoogle();
//
//       // Assert
//       expect(result, equals(mockedUser));
//       verify(mockFirebaseAuth.signInWithCredential(any)).called(1);
//     });
//
//     test('signInWithGoogle should handle errors gracefully', () async {
//       // Arrange
//       when(mockFirebaseAuth.signInWithCredential(any)).thenThrow('Error');
//
//       // Act
//       final result = await authService.signInWithGoogle();
//
//       // Assert
//       expect(result, isNull);
//       // Verify that the error is handled gracefully (e.g., showSnackBarError is called)
//     });
//
//     // Similar tests can be created for other methods in your AuthService class
//
//     tearDown(() {
//       // Cleanup if needed
//     });
//   });
// }
