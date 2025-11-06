import 'package:intl/intl.dart';

String formatDuration(Duration duration) {
  final minutes = duration.inMinutes.remainder(60).toString().padLeft(2, '0');
  final seconds = duration.inSeconds.remainder(60).toString().padLeft(2, '0');
  return '$minutes:$seconds';
}

String formatTelegramStyle(DateTime dateTime) {
  print("Date Time: ${dateTime}");
  final localDt = dateTime.toLocal();
  final now = DateTime.now();
  final today = DateTime(now.year, now.month, now.day);
  final date = DateTime(localDt.year, localDt.month, localDt.day);
  final difference = today.difference(date).inDays;

  if (difference == 0) {
    // Today → show time (e.g., 10:45 AM)
    return DateFormat('HH:mm').format(localDt);
  } else if (difference == 1) {
    // Yesterday
    return 'Yesterday';
  } else if (difference < 7 &&
      date.isAfter(today.subtract(Duration(days: now.weekday)))) {
    // This week → show weekday name (e.g., Mon, Tue)
    return DateFormat.E().format(localDt);
  } else {
    // Older → show like Jul 30, Aug 2
    return DateFormat.MMMd().format(localDt);
  }
}
