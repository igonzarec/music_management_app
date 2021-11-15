// Flutter imports:
import 'package:flutter/widgets.dart';

abstract class StateHandler<T> {
  Widget? stateHandlerWidget(T state){}
}
