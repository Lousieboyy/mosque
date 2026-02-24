class DataRefreshService {
  final Map<int, DateTime> _lastRefreshByPage = {};

  DateTime refreshPage(int pageIndex) {
    final now = DateTime.now();
    _lastRefreshByPage[pageIndex] = now;
    return now;
  }

  DateTime? lastRefresh(int pageIndex) => _lastRefreshByPage[pageIndex];
}
