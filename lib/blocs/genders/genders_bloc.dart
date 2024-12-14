import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';

import '../../models/category_model.dart';
import '../../repositories/genders_repository.dart';

part 'genders_event.dart';
part 'genders_state.dart';

class GendersBloc extends Bloc<GendersEvent, GendersState> {
  final GendersRepository gendersRepository;

  GendersBloc({required this.gendersRepository})
      : super(GendersState.initial()) {
    on<LoadGendersEvent>(_onLoadGenders);
  }

  Future<void> _onLoadGenders(
      LoadGendersEvent event, Emitter<GendersState> emit) async {
    emit(state.copyWith(status: GendersStatus.loading));
    try {
      final genders = await gendersRepository.getGenders();
      emit(state.copyWith(genders: genders, status: GendersStatus.loaded));
    } catch (error, stackTrace) {
      print("Error loading genders: $error");
      print("Stack trace: $stackTrace");

      emit(state.copyWith(status: GendersStatus.error));
    }
  }
}
