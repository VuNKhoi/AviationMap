import 'package:flutter_test/flutter_test.dart';
import 'package:aviationmap/core/error_handler.dart';

void main() {
  group('setupGlobalErrorHandling', () {
    test('does not throw when called', () {
      expect(() => setupGlobalErrorHandling(), returnsNormally);
    });
  });
}
