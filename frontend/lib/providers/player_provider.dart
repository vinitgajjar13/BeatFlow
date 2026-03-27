import 'package:flutter/foundation.dart';

class PlayerProvider extends ChangeNotifier {
  Duration _currentPosition = Duration.zero;
  Duration _totalDuration = Duration.zero;
  bool _isLoading = false;

  Duration get currentPosition => _currentPosition;
  Duration get totalDuration => _totalDuration;
  bool get isLoading => _isLoading;

  void updatePosition(Duration position) {
    _currentPosition = position;
    notifyListeners();
  }

  void updateDuration(Duration duration) {
    _totalDuration = duration;
    notifyListeners();
  }

  void setLoading(bool loading) {
    _isLoading = loading;
    notifyListeners();
  }

  void reset() {
    _currentPosition = Duration.zero;
    _totalDuration = Duration.zero;
    _isLoading = false;
    notifyListeners();
  }
}
