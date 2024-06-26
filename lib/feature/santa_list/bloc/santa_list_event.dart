part of 'santa_list_bloc.dart';

sealed class SantaListEvent {
  const SantaListEvent();
}

class SantaChildAdded extends SantaListEvent {
  final ChildInfo childInfo;

  const SantaChildAdded(
    this.childInfo,
  );
}

class SantaChildEdited extends SantaListEvent {
  final ChildInfo childInfo;

  const SantaChildEdited(
    this.childInfo,
  );
}
