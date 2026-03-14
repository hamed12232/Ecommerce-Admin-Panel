import 'package:flutter/material.dart';

class SidebarController extends ChangeNotifier {
  // Singleton instance
  static final SidebarController instance = SidebarController._internal();

  factory SidebarController() => instance;

  SidebarController._internal();

  String _activeItem = '';
  String _hoverItem = '';

  String get activeItem => _activeItem;
  String get hoverItem => _hoverItem;

  void changeActiveItem(String route) {
    _activeItem = route;
    notifyListeners();
  }

  void changeHoverItem(String route) {
    if (!isActive(route)) {
      _hoverItem = route;
      notifyListeners();
    }
  }

  bool isActive(String route) => _activeItem == route;

  bool isHovering(String route) => _hoverItem == route;
}
