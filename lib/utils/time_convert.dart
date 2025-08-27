class TimeConvert {
  

  static String timeAgo(DateTime date) {
    final now = DateTime.now().add(Duration(hours: 3));
    final difference = now.difference(date);
    
    if (difference.inDays > 8) {
      int weeks = (difference.inDays / 7).floor();
      return weeks == 1
        ? '1 week ago'
        : '$weeks weeks ago';
    } else if (difference.inDays >= 1) {
      return '${difference.inDays} day${difference.inDays > 1 ? 's' : ''} ago';
    } else if (difference.inHours >= 1) {
      return '${difference.inHours} hour${difference.inHours > 1 ? 's' : ''} ago';
    } else if (difference.inMinutes >= 1) {
      return '${difference.inMinutes} minute${difference.inMinutes > 1 ? 's' : ''} ago';
    } else {
      return 'just now';
    }
  }
}