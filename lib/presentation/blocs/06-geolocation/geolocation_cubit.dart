import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:geolocator/geolocator.dart';

part 'geolocation_state.dart';

class GeolocationCubit extends Cubit<GeolocationState> {
  final void Function((double lat, double lng) location)?
      onNewUserLocationCallback;

  GeolocationCubit({this.onNewUserLocationCallback})
      : super(const GeolocationState());

  Future<void> checkStatus() async {
    // verificar geolocation y permissions
    final serviceEnabled = await Geolocator.isLocationServiceEnabled();
    LocationPermission permissionGranted = await Geolocator.checkPermission();

    if (permissionGranted == LocationPermission.denied) {
      permissionGranted = await Geolocator.requestPermission();
    }

    emit(state.copyWith(
      serviceEnabled: serviceEnabled,
      permissionGranted: permissionGranted == LocationPermission.always ||
          permissionGranted == LocationPermission.whileInUse,
    ));
  }

  Future<void> watchUserLocation() async {
    // Obtener la ubicacion del usuario
    await checkStatus();

    if (!state.permissionGranted || !state.serviceEnabled) return;

    const locationSetting = LocationSettings(
      accuracy: LocationAccuracy.bestForNavigation,
      distanceFilter: 15,
    );

    Geolocator.getPositionStream(locationSettings: locationSetting)
        .listen((position) {
      //todo: Aqui ya sabemos la ubicacion del usuario
      final newLocation = (position.latitude, position.longitude);
      emit(state.copyWith(location: newLocation));

      onNewUserLocationCallback
          ?.call(newLocation); // llama a la function si es no null
    });
  }
}
