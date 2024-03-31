import 'package:country_picker/country_picker.dart';
import 'package:flutter/material.dart';
import 'package:santa_list/core/models/models.dart';
import 'package:santa_list/feature/santa_list/view/view.dart';
import 'package:santa_list/shared/utils.dart';

class ChildListTile extends StatelessWidget {
  const ChildListTile({
    super.key,
    required this.data,
    required this.onTap,
  });
  final ChildInfo data;
  final VoidCallback onTap;
  @override
  Widget build(BuildContext context) {
    final onPrimaryContainer = Theme.of(context).colorScheme.onPrimaryContainer;
    return ListTile(
      onTap: onTap,
      tileColor: Theme.of(context).colorScheme.primaryContainer.withOpacity(.6),
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
      leading: Text(
        data.country.flagEmoji,
        style: const TextStyle(
          fontSize: 20,
        ),
      ),
      title: Text(
        data.name,
        style: TextStyle(
          fontSize: 16,
          color: onPrimaryContainer,
        ),
      ),
      subtitle: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'Child Type - ${Utils.capitalize(data.childType.name)}',
            style: TextStyle(color: onPrimaryContainer),
          ),
          Text(
            data.country.name,
            style: TextStyle(
              color: onPrimaryContainer,
            ),
          ),
        ],
      ),
    );
  }
}
