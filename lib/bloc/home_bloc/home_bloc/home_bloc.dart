import 'package:flutter/foundation.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:online_pal_guardians/models/home/home_response.dart';
import 'package:online_pal_guardians/repositories/home_repository.dart';

part 'home_event.dart';
part 'home_state.dart';

class HomeBloc extends Bloc<HomeEvent, HomeState> {
  final HomeRepository homeRepository;

  HomeBloc({required this.homeRepository}) : super(const HomeInitial()) {
    on<HomeEventInitialized>(_onInitialized);
    on<GetHome>(_onGetHome);
  }

  void _onInitialized(
      HomeEventInitialized event,
      Emitter<HomeState> emit,
      ) {
    emit(const HomeInitial());
  }

  Future<void> _onGetHome(
      GetHome event,
      Emitter<HomeState> emit,
      ) async {
    emit(const HomeLoading());
    try {
      final response = await homeRepository.getHome();
      emit(GetHomeSuccess(response));
    } catch (e) {
      emit(HomeError(e.toString()));
    }
  }
}
