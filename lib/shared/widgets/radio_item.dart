import 'package:flutter/material.dart';

class RadioItem<T> extends StatelessWidget {
  const RadioItem(
      {super.key,
      required this.value,
      required this.groupValue,
      required this.label,
      this.onChanged});
  final T value;
  final T groupValue;
  final String label;
  final void Function(T? value)? onChanged;
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        onChanged?.call(value);
      },
      child: Row(
        children: [
          Text(
            label,
          ),
          Radio(
            value: value,
            groupValue: groupValue,
            onChanged: onChanged,
          ),
        ],
      ),
    );
  }
}
