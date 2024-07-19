// This is a basic Flutter widget test.
//
// To perform an interaction with a widget in your test, use the WidgetTester
// utility in the flutter_test package. For example, you can send tap and scroll
// gestures. You can also use WidgetTester to find child widgets in the widget
// tree, read text, and verify that the values of widget properties are correct.

import 'dart:convert';
import 'dart:math';
import 'package:flutter_test/flutter_test.dart';
import 'package:super90/xmiddleware/coffe_model.dart';
import 'package:super90/xmiddleware/middlewares/api_middleware.dart';
import 'package:super90/xmiddleware/middlewares/expected_types.dart';

void main() {
  test("convert Coffee and Brewing JSON", () {
    var response = jsonDecode('{"coffee": {'
        '"region": [{"id":1,"name":"John Doe"},{"id":2,"name":"Don Joeh"}],'
        '"country": {"id":2,"company":"ACME"}'
        '},'
        '"brewing": {'
        '"region": [{"id":1,"name":"John Doe"},{"id":2,"name":"Don Joeh"}],'
        '"country": {"id":2,"company":"ACME"}'
        '}'
        '}');

    var response1 = APIMiddleware<CoffeeAndBrewing, Map<String, dynamic>>()
        .convertAsPerModal(response, [CoffeeAndBrewing.fromJson], ExpectedTypes.getPettyCashVoucherDetails);
    print("Coffee Region Name=${response1.first.coffee.region.first.name}");
    print("Brewing Company=${response1.first.brewing.country.company}");
  });
}
