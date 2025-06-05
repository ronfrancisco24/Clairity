// Front-end functions for the notification screen

// Generates the time difference between the current time and the provided time
String getTimeAgo(DateTime date) {
  final now = DateTime.now();

  print(now);

  final diff = now.difference(date);

  print(diff);

  if (diff.isNegative) return 'Invalid Date.';

  if (diff.inSeconds < 60) return 'Just now';
  if (diff.inMinutes < 60) return '${diff.inMinutes} minute${diff.inMinutes == 1 ? '' : 's'} ago';
  if (diff.inHours < 24) return '${diff.inHours} hour${diff.inHours == 1 ? '' : 's'} ago';
  if (diff.inDays < 7) return '${diff.inDays} day${diff.inDays == 1 ? '' : 's'} ago';

  return '${date.year}-${date.month.toString().padLeft(2, '0')}-${date.day.toString().padLeft(2, '0')}';
}