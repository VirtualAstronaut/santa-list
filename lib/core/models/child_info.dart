import 'package:santa_list/core/enums/child_type.dart';

class ChildInfo {
  final String name;
  final String country;
  final ChildType childType;

  ChildInfo({
    required this.name,
    required this.country,
    required this.childType,
  });
}
