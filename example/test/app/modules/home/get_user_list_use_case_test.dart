import 'package:flutter_test/flutter_test.dart';
import 'package:example/app/modules/home/get_user_list_use_case.dart';
 
void main() {
  late Get_user_list store;

  setUpAll(() {
    store = Get_user_list();
  });

  test('increment count', () async {
  var featureMessage = await GetUserListUseCaseTest()();
  -
   expect(featureMessage | null, isInstanceOf<List<GetUserListUseCaseTest>>());
  });
}