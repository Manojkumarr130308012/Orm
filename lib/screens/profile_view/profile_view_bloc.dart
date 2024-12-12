import 'dart:convert';
import 'package:dms_dealers/screens/profile_view/profile_view_event.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../base/base_state.dart';
import '../../http/api_repository.dart';
import '../../http/httpurls.dart';
import '../../utils/contants.dart';
import '../../utils/singleton.dart';
import '../profile/model/profile_details.dart';


class ProfileViewBloc extends Bloc<ProfileViewEvent, BaseState> {
  ProfileViewBloc() : super(InitialState());


  @override
  Stream<BaseState> mapEventToState(
      ProfileViewEvent event,
      ) async* {
    if (event is ProfileViewEventInitialEvent) {
      yield LoadingState();
      yield SuccessState(successResponse: 'success');
    }else if (event is ProfileViewApiEvent) {
      dynamic response;
      yield LoadingState();
      print(event.arguments);
      final dynamic returnableValues = await APIRepository().dynamicRequest(
          "${HttpUrl.getProfileDetails}${FlashSingleton.instance.id}",
          userArguments: jsonEncode(event.arguments),
          method: ApiRequestMethod.get,
          isBearerTokenNeed: true,
          context: event.context);

      response = ProfileDetails.fromJson(returnableValues);

      yield SuccessState(successResponse: response);
    }
  }
}