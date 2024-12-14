part of 'genders_bloc.dart';

enum GendersStatus { initial, loading, loaded, error }

class GendersState extends Equatable {
  final List<Gender> genders;
  final GendersStatus status;

  const GendersState(
      {this.genders = const [], this.status = GendersStatus.initial});

  factory GendersState.initial() => const GendersState();

  GendersState copyWith({List<Gender>? genders, GendersStatus? status}) =>
      GendersState(
          genders: genders ?? this.genders, status: status ?? this.status);

  @override
  List<Object?> get props => [genders, status];
}
