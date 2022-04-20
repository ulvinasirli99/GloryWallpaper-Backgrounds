import 'dart:math';

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

  int page = Random().nextInt(20);

  void premiumRingtoneTrending() async {
    if (state is PremiumRingtoneZedgeLoading) return;
    final currentTState = state;
    List<PremimumRingtoneModel?>? oldRingtones = <PremimumRingtoneModel>[];
    if (currentTState is PremiumRingtoneZedgeLoaded) {
      oldRingtones = currentTState.premiumModelList;
    }
    emit(PremiumRingtoneZedgeLoading(oldRingtones, page == 1));
    premiumRingtoneRepository.getTrending(page).then((newRingtones) {
      page++;
      final ringtones = (state as PremiumRingtoneZedgeLoading).premiumModelList;
      ringtones!.addAll(newRingtones);
      emit(PremiumRingtoneZedgeLoaded(ringtones));
    });
  }
}
