part of 'home_bloc.dart';

sealed class HomeState extends Equatable {
  const HomeState();
  @override
  List<Object?> get props => [];
}

final class HomeInitial extends HomeState {
  const HomeInitial();
}

final class HomeLoadInProgress extends HomeState {
  const HomeLoadInProgress();
}

final class HomeLoadSuccess extends HomeState {
  HomeLoadSuccess({required List<Character> content})
    : content = List.unmodifiable(content);
  final List<Character> content;
  @override
  List<Object?> get props => [content];
}

final class HomeLoadFailure extends HomeState {
  const HomeLoadFailure({required this.exception});
  final Object exception;
  @override
  List<Object?> get props => [exception];
}
