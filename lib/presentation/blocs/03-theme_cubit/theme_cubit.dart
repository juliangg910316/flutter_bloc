import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

part 'theme_state.dart';

class ThemeCubit extends Cubit<ThemeState> {
  ThemeCubit() : super(const ThemeState(isDarkMode: false));

  void toggleTheme() {
    emit(state.copyWith(isDarkMode: !state.isDarkMode));
  }

  void setDarkMode() {
    emit(state.copyWith(isDarkMode: true));
  }

  void lightMode() {
    emit(state.copyWith(isDarkMode: false));
  }
}
