import 'package:localstorage/localstorage.dart';

class appInfo {
  static final API_URL = 'https://padellovers-2becb.firebaseio.com';
  static String ACTUAL_LEAGUE_ID = '-MFovwGq_u5K_0Ny9qr4';
  static LocalStorage storage;

  static LocalStorage getStorageInstance() {
    if (storage == null) {
      storage = new LocalStorage('storage');
      return storage;
    } else {
      return storage;
    }
  }
}
