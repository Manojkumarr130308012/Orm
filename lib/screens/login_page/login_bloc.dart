import 'dart:convert';

import 'package:dms_dealers/http/api_repository.dart';
import 'package:dms_dealers/http/httpurls.dart';
import 'package:dms_dealers/utils/contants.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../authenticatiom/bloc/authentication_event.dart';
import '../../base/base_state.dart';
import 'login_event.dart';
import 'model/LoginResponseModel.dart';


class LoginBloc extends Bloc<LoginEvent, BaseState> {
  LoginBloc() : super(InitialState());

  @override
  Stream<BaseState> mapEventToState(
    LoginEvent event,
  ) async* {
    if (event is LoginInitialEvent) {
      yield LoadingState();
      yield SuccessState(successResponse: 'success');
    } else if (event is LoginRequested) {
      dynamic response;
      yield LoadingState();
      print(event.arguments);
      final dynamic returnableValues = await APIRepository().dynamicRequest(
          HttpUrl.loginUrl,
          userArguments: jsonEncode(event.arguments),
          method: ApiRequestMethod.post,
          isBearerTokenNeed: false,
          context: event.context);

      if(returnableValues!=null){
        print("checklogger ${returnableValues}");
        response = Login.fromJson(returnableValues);
        yield SuccessState(successResponse: response);
      }else{
        print("checklogger error ${returnableValues}");
        yield FailureState(errorMessage: response);
      }
    }
  }

}
