part of 'products_bloc.dart';

abstract class ProductsEvent extends Equatable {
  const ProductsEvent();

  @override
  List<Object> get props => [];
}

class ProductsLoadEvent extends ProductsEvent {}

class ProductAddEvent extends ProductsEvent {
  final Product product;

  const ProductAddEvent(this.product);

  @override
  List<Object> get props => [product];
}

class ProductRemoveEvent extends ProductsEvent {
  final String productId;

  const ProductRemoveEvent(this.productId);

  @override
  List<Object> get props => [productId];
}

class ProductUpdateEvent extends ProductsEvent {
  final Product updatedProduct;

  const ProductUpdateEvent(this.updatedProduct);

  @override
  List<Object> get props => [updatedProduct];
}

class ProductFilterEvent extends ProductsEvent {
  final String filterQuery;

  const ProductFilterEvent(this.filterQuery);

  @override
  List<Object> get props => [filterQuery];
}
