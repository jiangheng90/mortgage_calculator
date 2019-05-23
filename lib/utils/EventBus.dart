import 'dart:ui';

import 'package:event_bus/event_bus.dart';

EventBus eventBus = new EventBus();

class ChangeThemeEvent{
  Color value;
  ChangeThemeEvent(this.value);
}