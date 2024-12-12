
import 'package:flutter/cupertino.dart';

import '../../utils/base_equatable.dart';

abstract class UrlpageEvent extends BaseEquatable {}

class UrlpageInitialEvent extends UrlpageEvent {
  BuildContext? context;
  dynamic arguments;

  UrlpageInitialEvent({this.context});

}
