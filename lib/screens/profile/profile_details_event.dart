
import 'package:flutter/cupertino.dart';

import '../../utils/base_equatable.dart';

abstract class ProfileDetailsEvent extends BaseEquatable {}

class ProfileDetailsEventInitialEvent extends ProfileDetailsEvent {
  BuildContext? context;
  dynamic arguments;

  ProfileDetailsEventInitialEvent({this.context});

}


class ProfileDetailsApiEvent extends ProfileDetailsEvent {
  ProfileDetailsApiEvent({this.context, this.arguments});
  BuildContext? context;
  dynamic arguments;
}