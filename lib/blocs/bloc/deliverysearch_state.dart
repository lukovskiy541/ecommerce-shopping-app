// ignore_for_file: public_member_api_docs, sort_constructors_first
part of 'deliverysearch_bloc.dart';



class DeliverySearchState extends Equatable {
  final List<String> deliverySearchList;
  final String searchTerm;
  DeliverySearchState({required this.deliverySearchList, required this.searchTerm});
  
  @override
  List<Object> get props => [deliverySearchList, searchTerm];

  factory DeliverySearchState.initial() {
  return DeliverySearchState(
    deliverySearchList: [],
    searchTerm: '',
  );
}

  DeliverySearchState copyWith({
    List<String>? deliverySearchList,
    String? searchTerm,
  }) {
    return DeliverySearchState(
      deliverySearchList: deliverySearchList ?? this.deliverySearchList,
      searchTerm: searchTerm ?? this.searchTerm,
    );
  }
}

  
