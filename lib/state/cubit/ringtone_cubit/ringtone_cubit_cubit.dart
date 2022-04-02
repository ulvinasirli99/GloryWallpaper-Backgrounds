import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:logger/logger.dart';
import 'package:wallpaper_app_flutter/model/ringtone/ringonte_model.dart';
import 'package:wallpaper_app_flutter/repository/ringtone_repository.dart';
part 'ringtone_cubit_state.dart';

class RingtoneCubitCubit extends Cubit<RingtoneCubitState> {
 
  RingtoneCubitCubit(this.repository)
 
      : super(
 
          RingtoneCubitInitial(),
 
        );
 
  final RingtoneRepository repository;

  List<LocalMusicModel> musicModelList = [];

  void getAllRingtoneListCallback() async {
 
    try {
 
      emit(RingtoneCubitLoading());
 
      musicModelList = await repository.requestRingtoneRepo();
 
      emit(RingtoneCubitLoaded(musicModelList));
 
    } catch (e) {
 
      emit(
 
        RingtoneCubitError(
 
          e.toString(),
 
        ),
 
      );
 
    }
 
  }

}