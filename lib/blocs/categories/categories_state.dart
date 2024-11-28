part of 'categories_bloc.dart';

enum CategoriesStatus { initial, loading, loaded, error }

class CategoriesState extends Equatable {
  final List<Category> categories;
  final CategoriesStatus status;

  const CategoriesState({
    this.categories = const [],
    this.status = CategoriesStatus.initial
  });

  factory CategoriesState.initial() => const CategoriesState();

  CategoriesState copyWith({
    List<Category>? categories,
    CategoriesStatus? status
  }) => CategoriesState(
    categories: categories ?? this.categories,
    status: status ?? this.status
  );

  @override
  List<Object?> get props => [categories, status];
}