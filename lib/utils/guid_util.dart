import 'dart:math';

/// Utility class for generating GUID
///
class GuidUtil {
  /// Generates a GUID.
  static String generateGuid() {
    final random = Random.secure();
    final values = List<int>.generate(16, (index) => random.nextInt(256));
    values[6] = (values[6] & 0x0f) | 0x40;
    values[8] = (values[8] & 0x3f) | 0x80;
    final bytes = values
        .map((value) => value.toRadixString(16).padLeft(2, '0'))
        .join()
        .toUpperCase();
    return '${bytes.substring(0, 8)}-${bytes.substring(8, 12)}-${bytes.substring(12, 16)}-${bytes.substring(16, 20)}-${bytes.substring(20)}';
  }
}
