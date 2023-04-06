import 'package:flutter/services.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:flutter_applovin_discovery_module/flutter_applovin_discovery_module_method_channel.dart';

void main() {
  MethodChannelFlutterApplovinModule platform =
      MethodChannelFlutterApplovinModule();
  const MethodChannel channel =
      MethodChannel('flutter_applovin_discovery_module');

  TestWidgetsFlutterBinding.ensureInitialized();

  setUp(() {
    channel.setMockMethodCallHandler((MethodCall methodCall) async {
      return '42';
    });
  });

  tearDown(() {
    channel.setMockMethodCallHandler(null);
  });

  test('getPlatformVersion', () async {
    expect(await platform.getPlatformVersion(), '42');
  });
}
