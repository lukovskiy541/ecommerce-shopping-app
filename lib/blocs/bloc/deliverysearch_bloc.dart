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
      if (state.deliverySearchList.isEmpty) {
        emit(state.copyWith(deliverySearchList: state.deliverySearchList));
      }

      if (event.newSearchTerm.isEmpty) {
        emit(state.copyWith(
          searchTerm: event.newSearchTerm,
          deliverySearchList: state.deliverySearchList,
        ));
      } else {
        final filteredList = state.deliverySearchList
            .where((element) => element
                .toLowerCase()
                .contains(event.newSearchTerm.toLowerCase()))
            .toList();

        emit(state.copyWith(
          searchTerm: event.newSearchTerm,
          deliverySearchList: filteredList,
        ));
      }
    });
  }
}
