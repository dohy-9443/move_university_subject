import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:fake_cloud_firestore/fake_cloud_firestore.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:move_university_subject/core/util/util.dart';
import 'package:move_university_subject/domain/entity/entity.dart';
import 'package:move_university_subject/domain/use_case/use_case.dart';
import 'package:move_university_subject/presentation/view_model/view_model.dart';

///
/// @Project name    : move_university_subject
/// @Class           : view_model_test.
/// @Created by      : baekdonghyun.
/// Created On       : 2024. 12. 9..
/// Description      : ViewModel 테스트 코드 최적화
///

class MockGetUserUseCase extends Mock implements GetUserUseCase {}
class MockCreateUserUseCase extends Mock implements CreateUserUseCase {}
class MockUpdateUserUseCase extends Mock implements UpdateUserUseCase {}
class MockDeleteUserUseCase extends Mock implements DeleteUserUseCase {}
class FakeGetUsersParams extends Fake implements GetUsersParams {}
class FakeCreateUserParams extends Fake implements CreateUserParams {}
class FakeUpdateUserParams extends Fake implements UpdateUserParams {}
class FakeDeleteUserParams extends Fake implements DeleteUserParams {}

void main() {
  late FakeFirebaseFirestore fakeFirestore;
  late MockGetUserUseCase mockGetUserUseCase;
  late MockCreateUserUseCase mockCreateUserUseCase;
  late MockUpdateUserUseCase mockUpdateUserUseCase;
  late MockDeleteUserUseCase mockDeleteUserUseCase;
  late UserViewModel viewModel;

  setUpAll(() {
    registerFallbackValue(FakeGetUsersParams());
    registerFallbackValue(FakeCreateUserParams());
    registerFallbackValue(FakeUpdateUserParams());
    registerFallbackValue(FakeDeleteUserParams());
  });

  setUp(() {
    fakeFirestore = FakeFirebaseFirestore();
    mockGetUserUseCase = MockGetUserUseCase();
    mockCreateUserUseCase = MockCreateUserUseCase();
    mockUpdateUserUseCase = MockUpdateUserUseCase();
    mockDeleteUserUseCase = MockDeleteUserUseCase();

    viewModel = UserViewModel(
      firestore: fakeFirestore,
      getUserUseCase: mockGetUserUseCase,
      createUserUseCase: mockCreateUserUseCase,
      updateUserUseCase: mockUpdateUserUseCase,
      deleteUserUseCase: mockDeleteUserUseCase,
    );
  });

  List<UserEntity> generateDummyUsers({int count = 10}) {
    return List.generate(
        count,
        (index) {
          return UserEntity(
            id: 'id_$index',
            name: 'User $index',
            email: 'user$index@example.com',
            address: 'Address $index',
            createdAt: Timestamp.now(),
            updatedAt: Timestamp.now(),
          );
        },
    );
  }

  group('fetchUsers', () {
    test('fetch user data test success', () async {
      final dummyUsers = generateDummyUsers();

      when(() => mockGetUserUseCase.call(any())).thenAnswer((_) async => dummyUsers);

      await viewModel.fetchUsers();

      expect(viewModel.state.value, equals(dummyUsers));
      verify(() => mockGetUserUseCase.call(any())).called(1);
    });

    test('fetch user data test error', () async {
      when(() => mockGetUserUseCase.call(any())).thenThrow(Exception('Failed to fetch users'));

      await viewModel.fetchUsers();

      expect(viewModel.state, isA<AsyncError>());
      verify(() => mockGetUserUseCase.call(any())).called(1);
    });
  });

  group('addUser', () {
    test('create user test success', () async {
      final newUser = generateDummyUsers(count: 1).first;

      when(() => mockCreateUserUseCase.call(any())).thenAnswer((_) async => Result.success('SUCCESS'));
      when(() => mockGetUserUseCase.call(any())).thenAnswer((_) async => []);

      await viewModel.addUser(newUser);

      expect(viewModel.state.value, equals([]));
      verify(() => mockCreateUserUseCase.call(any())).called(1);
      verify(() => mockGetUserUseCase.call(any())).called(1);
    });

    test('create user test error', () async {
      final newUser = generateDummyUsers(count: 1).first;

      when(() => mockCreateUserUseCase.call(any())).thenThrow(Exception('Failed to create user'));

      await viewModel.addUser(newUser);

      expect(viewModel.state, isA<AsyncError>());
      verify(() => mockCreateUserUseCase.call(any())).called(1);
    });
  });

  group('editUser', () {
    test('update user test success', () async {
      final updatedUser = generateDummyUsers(count: 1).first;

      when(() => mockUpdateUserUseCase.call(any())).thenAnswer((_) async => Result.success('SUCCESS'));
      when(() => mockGetUserUseCase.call(any())).thenAnswer((_) async => []);

      await viewModel.editUser(updatedUser);

      expect(viewModel.state.value, equals([]));
      verify(() => mockUpdateUserUseCase.call(any())).called(1);
      verify(() => mockGetUserUseCase.call(any())).called(1);
    });

    test('update user test error', () async {
      final updatedUser = generateDummyUsers(count: 1).first;

      when(() => mockUpdateUserUseCase.call(any())).thenThrow(Exception('Failed to update user'));

      await viewModel.editUser(updatedUser);

      expect(viewModel.state, isA<AsyncError>());
      verify(() => mockUpdateUserUseCase.call(any())).called(1);
    });
  });

  group('removeUser', () {
    test('remove user test success', () async {
      const userId = 'id_1';

      when(() => mockDeleteUserUseCase.call(any())).thenAnswer((_) async => Result.success('SUCCESS'));
      when(() => mockGetUserUseCase.call(any())).thenAnswer((_) async => []);

      await viewModel.removeUser(userId);

      expect(viewModel.state.value, equals([]));
      verify(() => mockDeleteUserUseCase.call(any())).called(1);
      verify(() => mockGetUserUseCase.call(any())).called(1);
    });

    test('remove user test error', () async {
      const userId = 'id_1';

      when(() => mockDeleteUserUseCase.call(any())).thenThrow(Exception('Failed to delete user'));

      await viewModel.removeUser(userId);

      expect(viewModel.state, isA<AsyncError>());
      verify(() => mockDeleteUserUseCase.call(any())).called(1);
    });
  });
}
