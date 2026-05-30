import 'package:intl/intl.dart';
import 'package:starter_project/gen/app_localizations_en.dart';
import 'package:timeago/timeago.dart' as timeago;

extension DateTimeX on DateTime {
  String get ddMMyyyy {
    return DateFormat('dd/MM/yyyy').format(this);
  }

  String get yyyyMMdd {
    return DateFormat('yyyy-MM-dd').format(this);
  }

  String get readableDate {
    return DateFormat.yMMMd().format(this);
  }

  String get fullReadableDate {
    return DateFormat.yMMMMEEEEd().format(this);
  }

  String get shortDate {
    return DateFormat('dd MMM').format(this);
  }

  String get postDate {
    return DateFormat('MMM d, yyyy').format(this);
  }

  String get compactDate {
    return DateFormat('d/M/yy').format(this);
  }

  String get time12h {
    return DateFormat.jm().format(this);
  }

  String get time24h {
    return DateFormat.Hm().format(this);
  }

  String get chatTime {
    return DateFormat('hh:mm a').format(this);
  }

  String get fullDateTime {
    return DateFormat('dd MMM yyyy • hh:mm a').format(this);
  }

  String get dateWithTime {
    return DateFormat.yMMMd().add_jm().format(this);
  }

  String get dayName {
    return DateFormat('EEEE').format(this);
  }

  String get shortDayName {
    return DateFormat('EEE').format(this);
  }

  String get monthName {
    return DateFormat('MMMM').format(this);
  }

  String get shortMonthName {
    return DateFormat('MMM').format(this);
  }

  String get timeAgo {
    return timeago.format(this);
  }

  String get shortTimeAgo {
    return timeago.format(this, locale: 'en_short');
  }

  String timeAgoWithLocale(String locale) {
    return timeago.format(this, locale: locale);
  }

  String get smartDate {
    if (isToday) {
      return AppLocalizationsEn().today;
    }

    if (isYesterday) {
      return AppLocalizationsEn().yesterday;
    }

    if (isTomorrow) {
      return AppLocalizationsEn().tomorrow;
    }

    return readableDate;
  }

  String get smartChatTime {
    if (isToday) {
      return chatTime;
    }

    if (isYesterday) {
      return AppLocalizationsEn().yesterday;
    }

    return shortDate;
  }

  bool get isToday {
    final now = DateTime.now();

    return year == now.year && month == now.month && day == now.day;
  }

  bool get isYesterday {
    final yesterday = DateTime.now().subtract(const Duration(days: 1));

    return year == yesterday.year &&
        month == yesterday.month &&
        day == yesterday.day;
  }

  bool get isTomorrow {
    final tomorrow = DateTime.now().add(const Duration(days: 1));

    return year == tomorrow.year &&
        month == tomorrow.month &&
        day == tomorrow.day;
  }

  bool get isWeekend {
    return weekday == DateTime.saturday || weekday == DateTime.sunday;
  }

  bool get isWeekday {
    return !isWeekend;
  }

  bool get isPast {
    return isBefore(DateTime.now());
  }

  bool get isFuture {
    return isAfter(DateTime.now());
  }

  bool get isCurrentYear {
    return year == DateTime.now().year;
  }

  bool get isLeapYear {
    return (year % 4 == 0 && year % 100 != 0) || year % 400 == 0;
  }

  DateTime get startOfDay {
    return DateTime(year, month, day);
  }

  DateTime get endOfDay {
    return DateTime(year, month, day, 23, 59, 59, 999);
  }

  DateTime get startOfMonth {
    return DateTime(year, month, 1);
  }

  DateTime get endOfMonth {
    return DateTime(year, month + 1, 0);
  }

  DateTime get startOfYear {
    return DateTime(year, 1, 1);
  }

  DateTime get endOfYear {
    return DateTime(year, 12, 31);
  }

  DateTime get utc {
    return toUtc();
  }

  DateTime get local {
    return toLocal();
  }

  int get daysAgo {
    return DateTime.now().difference(this).inDays;
  }

  int get daysUntil {
    return difference(DateTime.now()).inDays;
  }

  int get age {
    final today = DateTime.now();

    int age = today.year - year;

    if (today.month < month || (today.month == month && today.day < day)) {
      age--;
    }

    return age;
  }

  Duration get timeUntil {
    return difference(DateTime.now());
  }

  Duration get timeSince {
    return DateTime.now().difference(this);
  }

  String get iso8601 {
    return toIso8601String();
  }

  int get unixTimestamp {
    return millisecondsSinceEpoch;
  }

  String get displayDate {
    if (isToday) {
      return AppLocalizationsEn().today;
    }

    if (isYesterday) {
      return AppLocalizationsEn().yesterday;
    }

    return readableDate;
  }

  String get displayDateTime {
    if (isToday) {
      return 'Today • $chatTime';
    }

    if (isYesterday) {
      return 'Yesterday • $chatTime';
    }

    return fullDateTime;
  }
}
