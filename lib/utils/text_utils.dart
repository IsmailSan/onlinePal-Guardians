String truncateText(String text, int length) {
  return text.length > length ? '${text.substring(0, length)}...' : text;
}

String formatScheduleTime(String? time) {
  if (time == null || time.length < 4) return "-";
  final hour = time.substring(0, 2);
  final minute = time.substring(2, 4);
  return "$hour.$minute";
}

String formatDateToDDMMYYYY(String? isoDate) {
  if (isoDate == null) return '-';

  try {
    final dateTime = DateTime.parse(isoDate).toLocal();

    final day = dateTime.day.toString().padLeft(2, '0');
    final month = dateTime.month.toString().padLeft(2, '0');
    final year = dateTime.year.toString();

    return '$day/$month/$year';
  } catch (e) {
    return '-';
  }
}
