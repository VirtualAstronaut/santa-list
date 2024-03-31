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

  ChildInfo copyWith({
    String? name,
    Country? country,
    ChildType? childType,
    String? id,
  }) {
    return ChildInfo(
      name: name ?? this.name,
      country: country ?? this.country,
      childType: childType ?? this.childType,
      id: id ?? this.id,
    );
  }

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

  @override
  String toString() {
    return 'ChildInfo(name: $name, country: $country, childType: $childType, id: $id)';
  }
}
