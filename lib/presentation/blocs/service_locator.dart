import 'package:get_it/get_it.dart';

import '../../config/config.dart';
import 'blocs.dart';

GetIt getIt = GetIt.instance;

void serviceLocatorInit() {
  getIt.registerSingleton(UsernameCubit());
  getIt.registerSingleton(RouterSimpleCubit());
  getIt.registerSingleton(CounterCubit());
  getIt.registerSingleton(ThemeCubit());
  getIt.registerSingleton(GuestsBloc());
  getIt.registerSingleton(
    PokemonBloc(fetchPokemonName: PokemonInformation.getPokemonName),
  );
  // final historicBloc = getIt.registerSingleton(HistoricLocationBloc());
  getIt.registerSingleton(HistoricLocationBloc());

  getIt.registerSingleton(GeolocationCubit(
    // onNewUserLocationCallback: historicBloc.onNewUserLocation,
    onNewUserLocationCallback: getIt<HistoricLocationBloc>().onNewUserLocation,
  )..watchUserLocation());
}
