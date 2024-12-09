import 'package:firebase_core/firebase_core.dart';
import 'package:flutter_test/flutter_test.dart';

import 'utils/dummy_data_generator.dart';

void main() async {
  TestWidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();

  group('Dummy Data generator', () {
    test('Generate 200', () async {
      print("dummy data 200 개 생성중...");
      await dummyGenerate(200);
      print('dummy data 생성 완료');
    });
  });
}
