part of 'navigation_cubit.dart';

abstract class NavigationState extends Equatable {
  final PersistentTabController controller;
  const NavigationState({required this.controller});

  @override
  List<Object> get props => [controller.index];
}

class NavigationInitial extends NavigationState {
  NavigationInitial() : super(controller: PersistentTabController(initialIndex: 0));
}


