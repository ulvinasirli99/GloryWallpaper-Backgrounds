part of 'ringtone_cubit_cubit.dart';

abstract class RingtoneCubitState extends Equatable {
  const RingtoneCubitState();

  @override
  List<Object> get props => [];
}

class RingtoneCubitInitial extends RingtoneCubitState {}

class RingtoneCubitLoading extends RingtoneCubitState {}

class RingtoneCubitLoaded extends RingtoneCubitState {
  final List<LocalMusicModel> ringtoneList;

  RingtoneCubitLoaded(this.ringtoneList);
}

class RingtoneCubitError extends RingtoneCubitState {
  final String errorMessage;

  RingtoneCubitError(this.errorMessage);

  @override
  String toString() {
    Logger().e("RingtoneCubitError : " + errorMessage);
    return super.toString();
  }
}
