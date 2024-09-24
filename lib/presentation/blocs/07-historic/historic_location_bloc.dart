import 'dart:developer';

import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

part 'historic_location_event.dart';
part 'historic_location_state.dart';

class HistoricLocationBloc
    extends Bloc<HistoricLocationEvent, HistoricLocationState> {
  HistoricLocationBloc() : super(const HistoricLocationState()) {
    // on<HistoricLocationEvent>((event, emit) {
    //   // TODO: implement event handler
    // });

    on<NewLocation>(_onNewLocationhandler);
  }

  void onNewUserLocation((double lat, double lng) location) {
    log('${state.locations}');
    add(NewLocation(location));
  }

  void _onNewLocationhandler(
      NewLocation event, Emitter<HistoricLocationState> emit) {
    emit(state.copyWith(locations: [...state.locations, event.location]));
  }
}
