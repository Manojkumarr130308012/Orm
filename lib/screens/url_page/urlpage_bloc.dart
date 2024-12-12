import 'package:flutter_bloc/flutter_bloc.dart';

import '../../base/base_state.dart';
import 'urlpage_event.dart';

class UrlpageBloc extends Bloc<UrlpageEvent, BaseState> {
  UrlpageBloc() : super(InitialState());


  @override
  Stream<BaseState> mapEventToState(
      UrlpageEvent event,
      ) async* {
    if (event is UrlpageInitialEvent) {
      yield LoadingState();
      yield SuccessState(successResponse: 'success');
    }
  }
}