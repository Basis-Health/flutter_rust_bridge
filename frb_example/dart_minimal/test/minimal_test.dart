import 'dart:async';

import 'package:flutter_rust_bridge/flutter_rust_bridge.dart';
import 'package:frb_example_dart_minimal/src/rust/api/minimal.dart';
import 'package:frb_example_dart_minimal/src/rust/frb_generated.dart';
import 'package:test/test.dart';

Future<void> main() async {
  print('Action: Init rust (before)');
  await RustLib.init();
  print('Action: Init rust (after)');

  print('Action: Configure tests (before)');
  test('dart call minimalAdder', () async {
    print('Action: Call rust (before)');
    expect(await minimalAdder(a: 100, b: 200), 300);
    print('Action: Call rust (after)');
  });
  print('Action: Configure tests (end)');

  test('temp', () async {
    final Stream<TestDevice> _testEvent = testEventStream();
    _testEvent.listen((device) {
      print(device.values);
    });
    await pushTest(device: TestDevice(values: Uint64List.fromList([10, 20])));
    await Future.delayed(const Duration(seconds: 1));
  });
}
