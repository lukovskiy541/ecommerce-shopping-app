// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';

import 'package:ecommerce_app/models/product_model.dart';
import 'package:ecommerce_app/repositories/products_repository.dart';

part 'products_event.dart';
part 'products_state.dart';

class ProductsBloc extends Bloc<ProductsEvent, ProductsState> {
  ProductsBloc({required this.productsRepository}
  ) : super(ProductsState.Initial()){
        on<ProductsLoadEvent>(_onLoadProducts);
  }

  final ProductsRepository productsRepository;

  Future<void> _onLoadProducts(ProductsLoadEvent event, Emitter<ProductsState> emit) async {
    emit(ProductsState(products: [], status: ProductsStatus.loading));
    try {
      final products = await productsRepository.getProducts();
      emit(ProductsState(products: products, status: ProductsStatus.loaded));
    } catch (error) {
      emit(ProductsState(products: [], status: ProductsStatus.error));
    }
  }
}
