import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:us_ip_tv/main.dart';

part 'home_state.dart';

class HomeCubit extends Cubit<HomeState> {
  HomeCubit() : super(HomeInitial());

  //final LocalService _localService = LocalService();

  // initial control
  void initialControl() {
    if (m3uFilePath != '') {
      emit(HomeFullState());
    }
    emit(HomeEmptyState());
  }

  // local service
  Future<void> localService() async {
    //final data = _localService.fetchChannels();
  }
}
