class LanguageUtil {
  static String defaultLanguage = 'en';
  static const Map<String, Map<String, String>> _localizedValues = {
    'en': {
      'sendPhoto': 'Send photo',
      'photoSender': 'Photo Sender',
      'unknownError': 'Unknown error',
      'unknownMessage': 'Unknown message',
      'photoSent': 'Photo sent',
      'pleaseEnableAccessForCamera': 'Please enable access for camera/micro',
      'somethingWentWrongWithCamera': 'Something went wrong with Camera',
      'locationPermissionsArePermanentlyDenied': 'Location permissions are permanently denied, we cannot request permissions.',
      'locationPermissionDenied': 'Location Permission Denied',
      'enterCommentForPhoto': 'Enter comment for Photo'
    },
  };

  static set language(String lang) {
    defaultLanguage = lang;
  }

  static String get sendPhoto {
    return _localizedValues[defaultLanguage]!['sendPhoto']!;
  }
  static String get photoSender {
    return _localizedValues[defaultLanguage]!['photoSender']!;
  }
  static String get unknownError {
    return _localizedValues[defaultLanguage]!['unknownError']!;
  }
  static String get unknownMessage {
    return _localizedValues[defaultLanguage]!['unknownMessage']!;
  }
  static String get photoSent {
    return _localizedValues[defaultLanguage]!['photoSent']!;
  }
  static String get pleaseEnableAccessForCamera {
    return _localizedValues[defaultLanguage]!['pleaseEnableAccessForCamera']!;
  }
  static String get somethingWentWrongWithCamera {
    return _localizedValues[defaultLanguage]!['somethingWentWrongWithCamera']!;
  }
  static String get locationPermissionsArePermanentlyDenied {
    return _localizedValues[defaultLanguage]!['locationPermissionsArePermanentlyDenied']!;
  }
  static String get locationPermissionDenied {
    return _localizedValues[defaultLanguage]!['locationPermissionDenied']!;
  }
  static String get enterCommentForPhoto {
    return _localizedValues[defaultLanguage]!['enterCommentForPhoto']!;
  }
}