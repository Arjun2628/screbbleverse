import 'package:flutter/material.dart';

class DrawingProvider extends ChangeNotifier {
  List<Offset> _points = [];

  List<Offset> get points => _points;

  void addPoint(Offset point) {
    points.add(point);
    notifyListeners();
  }

  void clearPoints() {
    _points.clear();
    notifyListeners();
  }
}
