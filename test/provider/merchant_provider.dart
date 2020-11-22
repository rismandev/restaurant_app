import 'package:flutter_test/flutter_test.dart';
import 'package:siresto_app/data/api/api_merchant.dart';
import 'package:siresto_app/data/model/index.dart';
import 'package:siresto_app/data/provider/merchant_provider.dart';

void main() {
  group('Provider Test ', () {
    MerchantProvider merchantProvider;
    Map<String, dynamic> testDataJSON = {
      "id": "s1knt6za9kkfw1e867",
      "name": "Kafe Kita",
      "description":
          "Quisque rutrum. Aenean imperdiet. Etiam ultricies nisi vel augue. Curabitur ullamcorper ultricies nisi. Nam eget dui. Etiam rhoncus. Maecenas tempus, tellus eget condimentum rhoncus, sem quam semper libero, sit amet adipiscing sem neque sed ipsum. Nam quam nunc, blandit vel, luctus pulvinar, hendrerit id, lorem. Maecenas nec odio et ante tincidunt tempus. Donec vitae sapien ut libero venenatis faucibus. Nullam quis ante. Etiam sit amet orci eget eros faucibus tincidunt. Duis leo. Sed fringilla mauris sit amet nibh. Donec sodales sagittis magna. Sed consequat, leo eget bibendum sodales, augue velit cursus nunc,",
      "pictureId": "25",
      "city": "Gorontalo",
      "rating": 4
    };

    setUp(() {
      merchantProvider = MerchantProvider(apiMerchant: ApiMerchant());
    });

    test('Test Parsing JSON & should contain merchant', () {
      merchantProvider.testAdd(testDataJSON);

      bool testParsingJSON = merchantProvider.listMerchant
              .where((item) => item.id == Merchant.fromJson(testDataJSON).id)
              .length >
          0;
      expect(testParsingJSON, true);
    });

    test('Test Parsing JSON & should not contain merchant', () {
      merchantProvider.testRemove(Merchant.fromJson(testDataJSON));

      var testParsingJSON = merchantProvider.listMerchant.contains(
        Merchant.fromJson(testDataJSON),
      );
      expect(testParsingJSON, false);
    });
  });
}
