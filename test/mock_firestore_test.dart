import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:move_university_subject/data/data_sources/remote/remote.dart';

///
/// @Project name    : move_university_subject
/// @Class           : mock_firestore_test.
/// @Created by      : baekdonghyun.
/// Created On       : 2024. 12. 9..
/// Description      : 
///

class MockFirebaseFirestore extends Mock implements FirebaseFirestore {}
class MockCollectionReference extends Mock implements CollectionReference<Map<String, dynamic>> {}
class MockQuerySnapshot extends Mock implements QuerySnapshot<Map<String, dynamic>> {}
class MockQueryDocumentSnapshot extends Mock implements QueryDocumentSnapshot<Map<String, dynamic>> {}
class MockFirebase extends Mock implements FirebaseApp {}

void main() {
  late UserRemoteDataSource dataSource;
  late MockFirebaseFirestore mockFirestore;
  late MockCollectionReference mockCollectionReference;
  late MockQuerySnapshot mockQuerySnapshot;
  late MockQueryDocumentSnapshot mockDocumentSnapshot;

  setUp(() {
    TestWidgetsFlutterBinding.ensureInitialized();
    mockFirestore = MockFirebaseFirestore();
    mockCollectionReference = MockCollectionReference();
    mockQuerySnapshot = MockQuerySnapshot();
    mockDocumentSnapshot = MockQueryDocumentSnapshot();

    when(() => mockFirestore.collection(any())).thenReturn(mockCollectionReference);

    dataSource = UserRemoteDataSource(mockFirestore);
  });

  test('firebase test', () async {
    when(() => mockCollectionReference.orderBy(any())).thenReturn(mockCollectionReference);
    when(() => mockCollectionReference.limit(any())).thenReturn(mockCollectionReference);
    when(() => mockCollectionReference.get()).thenAnswer((_) async => mockQuerySnapshot);
    when(() => mockQuerySnapshot.docs).thenReturn([mockDocumentSnapshot]);

    when(() => mockDocumentSnapshot.id).thenReturn('1');
    when(() => mockDocumentSnapshot.data()).thenAnswer((_) {
      final data = {
        'name': 'User 1',
        'email': 'user_1@example.com',
        'address': 'Address 1',
        'createdAt': Timestamp.now(),
        'updatedAt': Timestamp.now(),
      };
      print('Mock data returned: $data');
      return data;
    });

    final result = await dataSource.fetch();

    expect(result.length, 1);
    expect(result.first.name, 'User 1');
  });
}