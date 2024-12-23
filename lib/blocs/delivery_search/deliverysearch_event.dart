part of 'deliverysearch_bloc.dart';

abstract class DeliverysearchEvent extends Equatable {
  const DeliverysearchEvent();

  @override
  List<Object> get props => [];
}

class InitializeDeliverySearchEvent extends DeliverysearchEvent {}

class SetSearchTermEvent extends DeliverysearchEvent {
  final String newSearchTerm;
  SetSearchTermEvent({
    required this.newSearchTerm,
  });
}
