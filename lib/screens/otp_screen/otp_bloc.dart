
import 'dart:convert';

import 'package:dms_dealers/http/api_repository.dart';
import 'package:dms_dealers/http/httpurls.dart';
import 'package:dms_dealers/screens/otp_screen/model/OtpVerify.dart';
import 'package:dms_dealers/utils/contants.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../base/base_state.dart';
import 'otp_event.dart';

class OTPBloc extends Bloc<OTPEvent, BaseState> {
  OTPBloc() : super(InitialState());


  @override
  Stream<BaseState> mapEventToState(
      OTPEvent event,
      ) async* {
    if (event is OTPInitialEvent) {
      yield LoadingState();
      yield SuccessState(successResponse: 'success');
    }else if (event is OtpUserEvent) {
      dynamic response;
      yield LoadingState();
      print(event.arguments);
      final dynamic returnableValues = await APIRepository().dynamicRequest(
          HttpUrl.verifyOtp,
          userArguments: jsonEncode(event.arguments),
          method: ApiRequestMethod.post,
          isBearerTokenNeed: false,
          context: event.context);

      response = OtpVerify.fromJson(returnableValues);

      yield SuccessState(successResponse: response);
    }
  }
}