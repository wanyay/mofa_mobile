class StringHelper {
  static final StringHelper _instance = StringHelper._();

  factory StringHelper() {
    return _instance;
  }

  StringHelper._();

  String englishToBurmeseNumber(String englishNumber) {
    final Map<String, String> numberMap = {
      '0': '၀',
      '1': '၁',
      '2': '၂',
      '3': '၃',
      '4': '၄',
      '5': '၅',
      '6': '၆',
      '7': '၇',
      '8': '၈',
      '9': '၉',
    };

    String burmeseNumber = '';

    for (int i = 0; i < englishNumber.length; i++) {
      String char = englishNumber[i];
      if (numberMap.containsKey(char)) {
        burmeseNumber += numberMap[char]!;
      } else {
        burmeseNumber += char;
      }
    }

    return burmeseNumber;
  }

  static String convertToBurmese(String englishNumber) {
    return _instance.englishToBurmeseNumber(englishNumber);
  }
}
