part of 'genders_bloc.dart';

abstract class GendersEvent extends Equatable {
  const GendersEvent();

  @override
  List<Object> get props => [];
}

class LoadGendersEvent extends GendersEvent {}
