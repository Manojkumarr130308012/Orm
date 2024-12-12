import 'package:flutter/cupertino.dart';

import '../../utils/base_equatable.dart';

abstract class DrawerEvent extends BaseEquatable {}

// ignore: must_be_immutable
class DrawerInitialEvent extends DrawerEvent {
  BuildContext? context;
  dynamic arguments;

  DrawerInitialEvent({this.context});
}

class ProfileDetailsApiEvent extends DrawerEvent {
  ProfileDetailsApiEvent({this.context, this.arguments});
  BuildContext? context;
  dynamic arguments;
}


class GetUserVehicleEvent extends DrawerEvent {
  GetUserVehicleEvent({this.context, this.arguments});
  BuildContext? context;
  dynamic arguments;
}