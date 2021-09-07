part of 'home_bloc.dart';

abstract class HomeEvent extends Equatable {
  const HomeEvent();

  @override
  List<Object> get props => [];
}

class HomeTapText extends HomeEvent {
  final String word;

  const HomeTapText(this.word);

  @override
  List<Object> get props => [word];
}

class HomeProcessing extends HomeEvent {
  final bool isProcessing;
  
  const HomeProcessing(this.isProcessing);

  @override
  List<Object> get props => [isProcessing];
}

class HomeSearchWord extends HomeEvent {
  final String word;

  const HomeSearchWord(this.word);

  @override
  List<Object> get props => [word];
}

class HomeToggleWordInfo extends HomeEvent {
  final bool show;
  const HomeToggleWordInfo(this.show);
}

class HomeToggleSearchBar extends HomeEvent {
  const HomeToggleSearchBar();
}

class HomeToggleTorch extends HomeEvent {
  const HomeToggleTorch();

  @override
  List<Object> get props => [];
}

class HomeToggleTts extends HomeEvent {
  final bool isStart;

  const HomeToggleTts(this.isStart);

  @override
  List<Object> get props => [isStart];
}

class HomePermissionsUpdated extends HomeEvent {
  final bool hasPermissions;

  const HomePermissionsUpdated(this.hasPermissions);

  @override
  List<Object> get props => [hasPermissions];
}
