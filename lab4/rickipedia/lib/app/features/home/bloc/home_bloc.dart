import 'dart:async';

import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:talker/talker.dart';

import '../../../../data/repositories/characters/character_repository_interface.dart';
import '../character.dart';
part 'home_event.dart';
part 'home_state.dart';

class HomeBloc extends Bloc<HomeEvent, HomeState> {
  HomeBloc({required this.repository, required this.talker})
    : super(const HomeInitial()) {
    on<HomeLoad>(_load);
  }
  final CharacterRepositoryInterface repository;
  final Talker talker;
  bool _loading = false;
  List<Character> _characters = const [];
  Character? findById(int? id) =>
      _characters.where((c) => c.id == id).firstOrNull;
  Future<void> _load(HomeLoad event, Emitter<HomeState> emit) async {
    if (_loading) {
      if (event.completer?.isCompleted == false) event.completer!.complete();
      return;
    }
    _loading = true;
    emit(const HomeLoadInProgress());
    try {
      _characters = List.unmodifiable(await repository.getCharacters());
      if (!emit.isDone) emit(HomeLoadSuccess(content: _characters));
    } catch (error, stack) {
      talker.handle(error, stack);
      if (!emit.isDone) emit(HomeLoadFailure(exception: error));
    } finally {
      _loading = false;
      if (event.completer?.isCompleted == false) event.completer!.complete();
    }
  }
}
