class HelperFunctions {
  static final HelperFunctions instance = HelperFunctions._init();

  HelperFunctions._init();

  factory HelperFunctions() {
    return instance;
  }

  parseToMinutesSeconds(int ms) {
    String data;
    Duration duration = Duration(milliseconds: ms);

    int minutes = duration.inMinutes;
    int seconds = (duration.inSeconds) - (minutes * 60);

    data = "$minutes:";
    if (seconds <= 9) data += "0";

    data += seconds.toString();
    return data;
  }
}
