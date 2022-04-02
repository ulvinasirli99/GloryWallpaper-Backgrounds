part of 'premium_ringtone_search_bloc.dart';

abstract class PremiumRingtoneSearchState extends Equatable {
  const PremiumRingtoneSearchState();

  @override
  List<Object> get props => [];
}

class PremiumRingtoneSearchInitial extends PremiumRingtoneSearchState {}

class PremiumRingtoneSearchLoading extends PremiumRingtoneSearchState {}

class PremiumRingtoneSearchLoaded extends PremiumRingtoneSearchState {
  final List<PremimumRingtoneModel?>? premiumModelList;

  PremiumRingtoneSearchLoaded(this.premiumModelList);
  @override
  List<Object> get props => [premiumModelList!];
}

class PremiumRingtoneSearchError extends PremiumRingtoneSearchState {
  final String errMsg;
  PremiumRingtoneSearchError(this.errMsg);
  @override
  List<Object> get props => [errMsg];
}
