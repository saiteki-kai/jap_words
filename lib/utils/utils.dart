import 'dart:math' as math;

class Utils {
  static String getJapaneseNumber(int number) {
    int len = (math.log(number + 1) / math.log(10)).ceil();
    int dec = math.pow(10, len - 1).toInt();

    String counter;
    switch (dec) {
      case 10:
        counter = "十";
        break;
      case 100:
        counter = "百";
        break;
      case 1000:
        counter = "千";
        break;
      case 10000:
        counter = "万";
        break;
      case 100000:
        counter = "十万";
        break;
      case 1000000:
        counter = "百万";
        break;
      case 10000000:
        counter = "千万";
        break;
      default:
        counter = "";
    }

    if (number > 9) {
      String res = "";
      if (number ~/ dec != 1) res += getJapaneseNumber(number ~/ dec);
      res += counter + getJapaneseNumber(number % dec);
      return res;
    }

    switch (number) {
      case 1:
        return "一";
      case 2:
        return "二";
      case 3:
        return "三";
      case 4:
        return "四";
      case 5:
        return "五";
      case 6:
        return "六";
      case 7:
        return "七	";
      case 8:
        return "八";
      case 9:
        return "九";
      default:
        return "";
    }
  }
}
