import 'package:country_picker/country_picker.dart';
import 'package:santa_list/core/enums/child_type.dart';

class ChildInfo {
  final String name;
  final Country country;
  final ChildType childType;

  ChildInfo({
    required this.name,
    required this.country,
    required this.childType,
  });
}
