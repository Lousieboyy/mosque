class NotificationService {
  final List<String> _notifications = [];

  void push(String message) {
    _notifications.insert(0, message);
  }

  String? peek() {
    if (_notifications.isEmpty) {
      return null;
    }
    return _notifications.first;
  }
}
