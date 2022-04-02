import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:logger/logger.dart';
import 'package:wallpaper_app_flutter/model/ringtone/pro_ringtone_model.dart';
import 'package:wallpaper_app_flutter/repository/premium_ringtone_repository.dart';
part 'premium_ringtone_zedge_state.dart';

class PremiumRingtoneZedgeCubit extends Cubit<PremiumRingtoneZedgeState> {
  PremiumRingtoneZedgeCubit(this.premiumRingtoneRepository)
      : super(PremiumRingtoneZedgeInitial());
  final PremiumRingtoneRepository premiumRingtoneRepository;

  List<PremimumRingtoneModel> premiumRingList = [];

  void premiumRingtoneTrending(int page) async {
    try {
      emit(PremiumRingtoneZedgeLoading());
      premiumRingList = await premiumRingtoneRepository.getTrending(page);
      Logger().d("PremiumRingtoneCubit : " + premiumRingList.toString());
      emit(PremiumRingtoneZedgeLoaded(premiumRingList));
    } catch (e) {
      emit(PremiumRingtoneZedgeError(
          "Error : ${e.toString()}", e.hashCode.toString()));
    }
  }
}
