
import 'package:flutter/cupertino.dart';

import '../../utils/base_equatable.dart';

abstract class ProfileViewEvent extends BaseEquatable {}

class ProfileViewEventInitialEvent extends ProfileViewEvent {
  BuildContext? context;
  dynamic arguments;

  ProfileViewEventInitialEvent({this.context});

}


class ProfileViewApiEvent extends ProfileViewEvent {
  ProfileViewApiEvent({this.context, this.arguments});
  BuildContext? context;
  dynamic arguments;
}