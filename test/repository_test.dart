import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:move_university_subject/data/data_sources/data_source.dart';
import 'package:move_university_subject/data/model/model.dart';
import 'package:move_university_subject/data/repository/repository.dart';
import 'package:move_university_subject/domain/entity/entity.dart';

///
/// @Project name    : move_university_subject
/// @Class           : repository_test.
/// @Created by      : baekdonghyun.
/// Created On       : 2024. 12. 9..
/// Description      : 
///

class MockFirebaseFirestore extends Mock implements FirebaseFirestore {}
class MockCollectionReference extends Mock implements CollectionReference<Map<String, dynamic>> {}
class MockQuerySnapshot extends Mock implements QuerySnapshot<Map<String, dynamic>> {}
class MockQueryDocumentSnapshot extends Mock implements QueryDocumentSnapshot<Map<String, dynamic>> {}


final List<Map<String, dynamic>> dummyData = List.generate(200, (index) {
  return {
    'id': 'id_$index',
    'name': 'User $index',
    'email': 'user$index@example.com',
    'address': 'Address $index',
    'createdAt': Timestamp.now(),
    'updatedAt': Timestamp.now(),
  };
});

List<MockQueryDocumentSnapshot> generateMockQueryDocumentSnapshots() {
  return dummyData.map((data) {
    final mockDoc = MockQueryDocumentSnapshot();
    when(() => mockDoc.id).thenReturn(data['id'] as String);
    when(() => mockDoc.data()).thenReturn(data);
    return mockDoc;
  }).toList();
}

void main() {
  late UserRemoteDataSource dataSource;
  late MockFirebaseFirestore mockFirestore;
  late MockCollectionReference mockCollectionReference;
  late MockQuerySnapshot mockQuerySnapshot;

  setUp(() {
    mockFirestore = MockFirebaseFirestore();
    mockCollectionReference = MockCollectionReference();
    mockQuerySnapshot = MockQuerySnapshot();

    when(() => mockFirestore.collection(any())).thenReturn(mockCollectionReference);
    dataSource = UserRemoteDataSource(mockFirestore);
  });

  test('fetch should return a list of 200 UserModel', () async {
    // Arrange
    final mockDocs = generateMockQueryDocumentSnapshots();
    when(() => mockCollectionReference.orderBy(any()))
        .thenReturn(mockCollectionReference);
    when(() => mockCollectionReference.limit(any()))
        .thenReturn(mockCollectionReference);
    when(() => mockCollectionReference.get())
        .thenAnswer((_) async => mockQuerySnapshot);
    when(() => mockQuerySnapshot.docs).thenReturn(mockDocs);

    // Act
    final result = await dataSource.fetch();

    // Assert
    expect(result.length, 200);
    expect(result.first.name, 'User 0');
    expect(result.last.name, 'User 199');
  });
}