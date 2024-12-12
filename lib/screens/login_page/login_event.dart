import 'package:flutter/material.dart';

import '../../utils/base_equatable.dart';

abstract class LoginEvent extends BaseEquatable {}

class LoginInitialEvent extends LoginEvent {
 BuildContext? context;
  dynamic arguments;
  LoginInitialEvent({this.context});
}

class LoginRequested extends LoginEvent {
 LoginRequested({this.context, this.arguments});
 BuildContext? context;
 dynamic arguments;
}

class LogoutRequested extends LoginEvent {}

class ForgotPasswordRequested extends LoginEvent {
 final String email;
  ForgotPasswordRequested(this.email);
 @override
 List<Object> get props => [email];
}


