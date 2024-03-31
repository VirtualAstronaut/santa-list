part of 'santa_list_bloc.dart';

sealed class SantaListState {
  const SantaListState();
}

final class SantaListEmpty extends SantaListState {
  const SantaListEmpty();
}

final class SantaListData extends SantaListState {
  final List<ChildInfo> childInfo;

  const SantaListData({required this.childInfo});
  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;
    return other is SantaListData && listEquals(childInfo, other.childInfo);
  }

  @override
  int get hashCode => childInfo.hashCode;

  @override
  String toString() {
    return 'SantaListData(childInfo: $childInfo)';
  }
}
