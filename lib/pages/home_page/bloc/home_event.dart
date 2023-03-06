class HomePageEvent {}

class LoadingHomePageEvent extends HomePageEvent {
  String action;
  LoadingHomePageEvent({required this.action});
}

class ChangeActionEvent extends HomePageEvent {
  String action;
  ChangeActionEvent({required this.action});
}
