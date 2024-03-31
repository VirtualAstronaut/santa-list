import 'package:country_picker/country_picker.dart';
import 'package:santa_list/core/enums/child_type.dart';

class ChildInfo {
  final String name;
  final Country country;
  final ChildType childType;
  final String id;

  const ChildInfo({
    required this.name,
    required this.country,
    required this.childType,
    required this.id,
  });

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;

    return other is ChildInfo &&
        other.name == name &&
        other.country == country &&
        other.childType == childType;
  }

  @override
  int get hashCode => Object.hash(name, country, childType);
}
