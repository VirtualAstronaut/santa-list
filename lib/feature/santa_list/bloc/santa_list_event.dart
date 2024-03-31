part of 'santa_list_bloc.dart';

sealed class SantaListEvent {
  const SantaListEvent();
}

class ChildAdded extends SantaListEvent {
  final ChildInfo childInfo;

  const ChildAdded(
    this.childInfo,
  );
}
