part of 'santa_list_bloc.dart';

class SantaListState {
  const SantaListState();
}

final class SantaListEmpty extends SantaListState {
  const SantaListEmpty();
}

final class SantaListData extends SantaListState {
  final List<ChildInfo> childInfo;

  SantaListData({required this.childInfo});
}
