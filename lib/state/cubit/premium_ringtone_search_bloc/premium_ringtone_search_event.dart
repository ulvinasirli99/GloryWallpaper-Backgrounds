part of 'premium_ringtone_search_bloc.dart';

abstract class PremiumRingtoneSearchEvent extends Equatable {
  const PremiumRingtoneSearchEvent();

  @override
  List<Object> get props => [];
}

class PremiumSearhEvent extends PremiumRingtoneSearchEvent {
  final int page;
  final String searchField;

  PremiumSearhEvent(this.page, this.searchField);
  @override
  List<Object> get props => [page, searchField];
}
