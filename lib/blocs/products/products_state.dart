// ignore_for_file: public_member_api_docs, sort_constructors_first

part of 'products_bloc.dart';

class ProductsState extends Equatable {
  final List<Product> products;
  ProductsState({
    required this.products,
  });

  factory ProductsState.Initial() {
    return ProductsState(products: []);
  }

  ProductsState copyWith({
    List<Product>? products,
  }) {
    return ProductsState(
      products: products ?? this.products,
    );
  }

  @override
  String toString() => 'ProductsState(products: $products)';

  @override
  List<Object> get props => [products];
}
