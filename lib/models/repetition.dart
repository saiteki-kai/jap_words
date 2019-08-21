// https://www.supermemo.com/en/archives1990-2015/english/ol/sm2

class Repetition {
  double easiness; // easiness factor (EF)
  int repetitions; // number of repetitions
  int interval; // interval in days
  int nextDate; // next review date
  String wordId; // information bridge

  Repetition({
    this.easiness = 2.5,
    this.interval = 0,
    this.repetitions = 0,
    this.nextDate,
    this.wordId,
  });

  _calculateInterval() {
    if (this.repetitions <= 1) {
      return 1;
    } else if (this.repetitions == 2) {
      return 6;
    } else {
      return (this.interval * this.easiness).round();
    }
  }

  _calculateEF(int q) {
    final ef = this.easiness + (0.1 - (5 - q) * (0.08 + (5 - q) * 0.02));

    if (ef < 1.3) {
      return 1.3;
    } else {
      return ef;
    }
  }

  calculateNextDate(int quality) {
    this.easiness = _calculateEF(quality);

    if (quality < 3) {
      this.repetitions = 0;
    } else {
      this.repetitions++;
    }

    this.interval = _calculateInterval();

    const millisInDay = 24 * 60 * 60 * 1000;
    var now = DateTime.now().millisecondsSinceEpoch;
    this.nextDate = now + this.interval * millisInDay;
  }

  factory Repetition.fromMap(Map<String, dynamic> json) {
    return Repetition(
      easiness: json["easiness"],
      repetitions: json["repetitions"],
      interval: json["interval"],
      nextDate: json["nextDate"] ?? DateTime.now().millisecondsSinceEpoch,
      wordId: json["wordId"],
    );
  }

  Map<String, dynamic> toMap() => {
        "easiness": easiness,
        "repetitions": repetitions,
        "interval": interval,
        "nextDate": nextDate,
        "wordId": wordId,
      };
}
