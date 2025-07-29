import 'package:flutter_test/flutter_test.dart';
import 'package:aviationmap/core/logger.dart';

void main() {
  group('AppLogger', () {
    test('d prints debug message', () {
      expect(() => AppLogger.d('debug message'), returnsNormally);
    });
    test('i prints info message', () {
      expect(() => AppLogger.i('info message'), returnsNormally);
    });
    test('w prints warning message', () {
      expect(() => AppLogger.w('warn message'), returnsNormally);
    });
    test('e prints error message', () {
      expect(() => AppLogger.e('error message'), returnsNormally);
    });
  });
}
