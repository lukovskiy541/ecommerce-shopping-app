import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';

import '../../models/category_model.dart';
import '../../repositories/categories_repository.dart';

part 'categories_event.dart';
part 'categories_state.dart';

class CategoriesBloc extends Bloc<CategoriesEvent, CategoriesState> {
  final CategoriesRepository categoriesRepository;

  CategoriesBloc({ required this.categoriesRepository})
      : super(CategoriesState.initial()) {
    on<LoadCategoriesEvent>(_onLoadCategories);
  }

  Future<void> _onLoadCategories(
    LoadCategoriesEvent event, Emitter<CategoriesState> emit) async {
  emit(state.copyWith(status: CategoriesStatus.loading));
  try {
    final categories = await categoriesRepository.getCategories();
    emit(state.copyWith(
        categories: categories, status: CategoriesStatus.loaded));
  } catch (error, stackTrace) {
    print("Error loading categories: $error");
    print("Stack trace: $stackTrace");


    emit(state.copyWith(status: CategoriesStatus.error));
  }
}
}
