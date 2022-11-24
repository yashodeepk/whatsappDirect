import 'dart:io';

class AdHelper {
  static String get bannerAdUnitId {
    if (Platform.isAndroid) {
      return 'ca-app-pub-9575384856484892/2999805140';
    }
    throw UnsupportedError("Unsupported platform");
  }
}
