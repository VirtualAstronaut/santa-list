import 'package:country_picker/country_picker.dart';
import 'package:flutter/material.dart';
import 'package:santa_list/core/enums/child_type.dart';
import 'package:santa_list/shared/shared.dart';
import 'package:santa_list/shared/utils.dart';
import 'package:santa_list/shared/widgets/radio_item.dart';

class AddChildpage extends StatelessWidget {
  const AddChildpage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Add Child'),
      ),
      body: const Padding(
        padding: EdgeInsets.all(16.0),
        child: _Body(),
      ),
      floatingActionButton: _DoneFab(
        onSave: () {},
      ),
    );
  }
}

class _Body extends StatefulWidget {
  const _Body({super.key});

  @override
  State<_Body> createState() => _BodyState();
}

class _BodyState extends State<_Body> {
  late final TextEditingController nameController;
  late final TextEditingController countryController;

  static const _columnSpacing = 15.0;

  Country? country;
  ChildType? childType;
  @override
  void initState() {
    nameController = TextEditingController();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        AppTextField(
          controller: nameController,
          label: 'Name',
        ),
        const SizedBox(
          height: _columnSpacing,
        ),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            const Text('Pick Country'),
            FilledButton.tonal(
              onPressed: onCountryPick,
              child: Text(
                country == null ? 'No Country Selected' : country!.name,
              ),
            )
          ],
        ),
        const SizedBox(
          height: _columnSpacing,
        ),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            const Text('Child Type'),
            Row(
              children: [
                ...ChildType.values.map(
                  (e) {
                    return RadioItem<ChildType?>(
                      value: e,
                      groupValue: childType,
                      onChanged: onChildTypePick,
                      label: Utils.capitalize(e.name),
                    );
                  },
                )
              ],
            )
          ],
        )
      ],
    );
  }

  void onChildTypePick(ChildType? childType) {
    this.childType = childType;
    setState(() {});
  }

  void onCountryPick() {
    showCountryPicker(
      context: context,
      showPhoneCode: false,
      onSelect: (Country country) {
        this.country = country;
        setState(() {});
      },
    );
  }
}

class _DoneFab extends StatelessWidget {
  const _DoneFab({super.key, required this.onSave});
  final VoidCallback onSave;
  @override
  Widget build(BuildContext context) {
    return FloatingActionButton.extended(
      onPressed: () {},
      icon: const Icon(Icons.save),
      label: const Text('Save'),
    );
  }
}
