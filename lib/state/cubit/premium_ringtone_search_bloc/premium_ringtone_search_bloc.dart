import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:logger/logger.dart';
import 'package:wallpaper_app_flutter/model/ringtone/pro_ringtone_model.dart';
import 'package:wallpaper_app_flutter/repository/premium_ringtone_repository.dart';

part 'premium_ringtone_search_event.dart';
part 'premium_ringtone_search_state.dart';

class PremiumRingtoneSearchBloc
    extends Bloc<PremiumRingtoneSearchEvent, PremiumRingtoneSearchState> {
  final PremiumRingtoneRepository repository;
  PremiumRingtoneSearchBloc(this.repository)
      : super(PremiumRingtoneSearchInitial()) {
    List<PremimumRingtoneModel> searchModelListR = [];
    on<PremiumRingtoneSearchEvent>((event, emit) async {
      if (event is PremiumSearhEvent) {
        try {
          emit(PremiumRingtoneSearchLoading());
          searchModelListR = await repository.getResults(
            event.searchField,
            event.page,
          );
          Logger().i("Premium Search List : " + searchModelListR.toString());
          emit(
            PremiumRingtoneSearchLoaded(
              searchModelListR,
            ),
          );
        } catch (e) {
          emit(PremiumRingtoneSearchError(
            e.toString(),
          ));
        }
      }
    });
  }
}
