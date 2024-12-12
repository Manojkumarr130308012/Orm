
import 'package:flutter/cupertino.dart';

import '../../utils/base_equatable.dart';

abstract class OTPEvent extends BaseEquatable {}

class OTPInitialEvent extends OTPEvent {
  BuildContext? context;
  dynamic arguments;

  OTPInitialEvent({this.context});

}

class OtpUserEvent extends OTPEvent {
  OtpUserEvent({this.context, this.arguments});
  BuildContext? context;
  dynamic arguments;
}