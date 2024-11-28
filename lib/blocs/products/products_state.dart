// ignore_for_file: public_member_api_docs, sort_constructors_first

part of 'products_bloc.dart';

enum ProductsStatus {
  initial,
  loading,
  loaded,
  error,
}

class ProductsState extends Equatable {
  final List<Product> products;
  final ProductsStatus status;
  ProductsState({
    required this.products,
    required this.status,
  });

  factory ProductsState.Initial() {
    return ProductsState(products: [], status: ProductsStatus.initial);
  }


  @override
  List<Object> get props => [products, status];

  ProductsState copyWith({
    List<Product>? products,
    ProductsStatus? status,
  }) {
    return ProductsState(
      products: products ?? this.products,
      status: status ?? this.status,
    );
  }

  @override
  bool get stringify => true;
}
