part of 'premium_ringtone_zedge_cubit.dart';

abstract class PremiumRingtoneZedgeState extends Equatable {
  const PremiumRingtoneZedgeState();

  @override
  List<Object> get props => [];
}

class PremiumRingtoneZedgeInitial extends PremiumRingtoneZedgeState {}

class PremiumRingtoneZedgeLoading extends PremiumRingtoneZedgeState {
  final List<PremimumRingtoneModel?>? premiumModelList;
  final bool isFirstFetch;

  PremiumRingtoneZedgeLoading(this.premiumModelList, this.isFirstFetch);
}

class PremiumRingtoneZedgeLoaded extends PremiumRingtoneZedgeState {
  final List<PremimumRingtoneModel?>? premiumModelList;

  PremiumRingtoneZedgeLoaded(this.premiumModelList);
}

class PremiumRingtoneZedgeError extends PremiumRingtoneZedgeState {
  final String errMessgae;
  final String errCode;

  PremiumRingtoneZedgeError(this.errMessgae, this.errCode);
}
