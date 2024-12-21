import 'package:bloc/bloc.dart';
import 'package:ecommerce_app/blocs/bloc/fetch_departments.dart';
import 'package:equatable/equatable.dart';

part 'deliverysearch_event.dart';
part 'deliverysearch_state.dart';

class DeliverysearchBloc
    extends Bloc<DeliverysearchEvent, DeliverySearchState> {
  DeliverysearchBloc() : super(DeliverySearchState.initial()) {
    on<InitializeDeliverySearchEvent>((event, emit) async {
      final departments = await fetchDepartments();
      print('Отримано дані: $departments');
      emit(state.copyWith(deliverySearchList: departments));
    });

    on<SetSearchTermEvent>((event, emit) {
     final filteredList = state.deliverySearchList
          .where((element) => element.toLowerCase().contains(event.newSearchTerm.toLowerCase()))
          .toList();
          print('Filtered list: $filteredList');
      emit(state.copyWith(
        searchTerm: event.newSearchTerm,
        deliverySearchList: filteredList,
      ));
    });
  }
}
