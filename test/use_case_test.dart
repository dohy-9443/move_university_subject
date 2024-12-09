import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:move_university_subject/core/exception/exception.dart';
import 'package:move_university_subject/core/util/util.dart';
import 'package:move_university_subject/domain/entity/entity.dart';
import 'package:move_university_subject/domain/repository/repository.dart';
import 'package:move_university_subject/domain/use_case/use_case.dart';

import 'utils/dummy_data_generator.dart';

///
/// @Project name    : move_university_subject
/// @Class           : use_case_test.
/// @Created by      : baekdonghyun.
/// Created On       : 2024. 12. 9..
/// Description      : 
///

class MockUserRepository extends Mock implements IUserRepository {}

class FakeUserEntity extends Fake implements UserEntity {}

void main() {
  late MockUserRepository mockRepository;
  late GetUserUseCase getUserUseCase;
  late CreateUserUseCase createUserUseCase;
  late UpdateUserUseCase updateUserUseCase;
  late DeleteUserUseCase deleteUserUseCase;

  setUpAll(() {
    registerFallbackValue(FakeUserEntity());
  });

  setUp(() {
    mockRepository = MockUserRepository();
    getUserUseCase = GetUserUseCase(mockRepository);
    createUserUseCase = CreateUserUseCase(mockRepository);
    updateUserUseCase = UpdateUserUseCase(mockRepository);
    deleteUserUseCase = DeleteUserUseCase(mockRepository);

  });

  test('GetUserUseCase test', () async {
    when(() => mockRepository.fetch(startAfter: any(named: 'startAfter')))
        .thenAnswer((_) async => Result.success(dummyUserEntities));

    final result = await getUserUseCase(GetUsersParams(startAfter: null));

    expect(result.length, 200);
    expect(result.first.name, 'User 0');
    expect(result.last.name, 'User 199');

    verify(() => mockRepository.fetch(startAfter: any(named: 'startAfter'))).called(1);
  });

  test('CreateUserUseCase test success', () async {
    final newUser = UserEntity(
      id: 'id_new',
      name: 'New User',
      email: 'newuser@example.com',
      address: 'New Address',
      createdAt: Timestamp.now(),
      updatedAt: Timestamp.now(),
    );

    when(() => mockRepository.create(any())).thenAnswer((_) async => Result.success('SUCCESS'));

    final result = await createUserUseCase(CreateUserParams(newUser));

    expect(result.isSuccess, true);
    expect(result.data, 'SUCCESS');
    verify(() => mockRepository.create(newUser)).called(1);
  });

  test('CreateUserUseCase test failure', () async {
    final newUser = UserEntity(
      id: 'id_new',
      name: 'New User',
      email: 'newuser@example.com',
      address: 'New Address',
      createdAt: Timestamp.now(),
      updatedAt: Timestamp.now(),
    );

    when(() => mockRepository.create(any())).thenThrow(Exception('Repository failure'));

    final result = await createUserUseCase(CreateUserParams(newUser));

    expect(result.isFailure, true);
    expect(result.error, isA<ServerFailure>());
    expect((result.error as ServerFailure).message, contains('USE CASE ERROR'));
    verify(() => mockRepository.create(newUser)).called(1);
  });

  test('UpdateUserUseCase test success', () async {
    final updatedUser = UserEntity(
      id: 'id_1',
      name: 'Updated User',
      email: 'updateduser@example.com',
      address: 'Updated Address',
      createdAt: Timestamp.now(),
      updatedAt: Timestamp.now(),
    );

    when(() => mockRepository.update(any())).thenAnswer((_) async => Result.success('SUCCESS'));

    // Act
    final result = await updateUserUseCase(UpdateUserParams(updatedUser));

    // Assert
    expect(result.isSuccess, true);
    expect(result.data, 'SUCCESS');
    verify(() => mockRepository.update(updatedUser)).called(1);
  });

  test('UpdateUserUseCase test failure', () async {
    final updatedUser = UserEntity(
      id: 'id_1',
      name: 'Updated User',
      email: 'updateduser@example.com',
      address: 'Updated Address',
      createdAt: Timestamp.now(),
      updatedAt: Timestamp.now(),
    );

    when(() => mockRepository.update(any())).thenThrow(Exception('Repository failure'));

    final result = await updateUserUseCase(UpdateUserParams(updatedUser));

    expect(result.isFailure, true);
    expect(result.error, isA<ServerFailure>());
    expect((result.error as ServerFailure).message, contains('USE CASE ERROR'));
    verify(() => mockRepository.update(updatedUser)).called(1);
  });

  test('DeleteUserUseCase test success', () async {
    const userId = 'id_1';

    when(() => mockRepository.delete(any())).thenAnswer((_) async => Result.success('SUCCESS'));

    final result = await deleteUserUseCase(DeleteUserParams(userId));

    expect(result.isSuccess, true);
    expect(result.data, 'SUCCESS');
    verify(() => mockRepository.delete(userId)).called(1);
  });

  test('DeleteUserUseCase test failure', () async {
    const userId = 'id_1';

    when(() => mockRepository.delete(any())).thenThrow(Exception('Repository failure'));

    final result = await deleteUserUseCase(DeleteUserParams(userId));

    expect(result.isFailure, true);
    expect(result.error, isA<ServerFailure>());
    expect((result.error as ServerFailure).message, contains('USE CASE ERROR'));
    verify(() => mockRepository.delete(userId)).called(1);
  });

}