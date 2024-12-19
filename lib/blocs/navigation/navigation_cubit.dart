import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:persistent_bottom_nav_bar_v2/persistent_bottom_nav_bar_v2.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
part 'navigation_state.dart';

class NavigationCubit extends Cubit<NavigationState> {
  NavigationCubit() : super(NavigationInitial());

  void switchTab(int index) {
    state.controller.jumpToTab(index);
  }

  PersistentTabController get controller => state.controller;
}
