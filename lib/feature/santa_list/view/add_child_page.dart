import 'package:country_picker/country_picker.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:santa_list/core/enums/child_type.dart';
import 'package:santa_list/core/models/models.dart';
import 'package:santa_list/feature/santa_list/bloc/santa_list_bloc.dart';
import 'package:santa_list/shared/shared.dart';
import 'package:santa_list/shared/utils.dart';
import 'package:santa_list/shared/widgets/radio_item.dart';
import 'package:uuid/uuid.dart';

class AddChildpage extends StatelessWidget {
  const AddChildpage({super.key, required this.bloc, this.childInfo});
  final SantaListBloc bloc;
  final ChildInfo? childInfo;
  @override
  Widget build(BuildContext context) {
    return BlocProvider.value(
      value: bloc,
      child: _Body(
        childInfo: childInfo,
      ),
    );
  }
}

class _Body extends StatefulWidget {
  const _Body({
    super.key,
    required this.childInfo,
  });
  final ChildInfo? childInfo;
  @override
  State<_Body> createState() => _BodyState();
}

class _BodyState extends State<_Body> {
  late final TextEditingController nameController;
  late final TextEditingController countryController;

  static const _columnSpacing = 15.0;

  late Country country;
  ChildType childType = ChildType.nice;

  final formKey = GlobalKey<FormState>();
  @override
  void initState() {
    super.initState();

    nameController = TextEditingController();
    final childInfo = widget.childInfo;

    if (childInfo != null) {
      nameController.text = childInfo.name;
      this.country = childInfo.country;
      childType = childInfo.childType;
      return;
    }

    final country = CountryService().findByCode('IN');
    if (country != null) {
      this.country = country;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Add Child'),
      ),
      floatingActionButton: _DoneFab(
        label: widget.childInfo == null ? 'Save' : 'Update',
        onSave: onSave,
      ),
      body: Form(
        key: formKey,
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            children: [
              AppTextField(
                controller: nameController,
                label: 'Name',
              ),
              const SizedBox(
                height: _columnSpacing,
              ),
              _PickCountry(
                country: country,
                onCountryPick: onCountryPick,
              ),
              const SizedBox(
                height: _columnSpacing,
              ),
              _ChildTypeRadios(
                childType: childType,
                onChildTypePick: onChildTypePick,
              ),
            ],
          ),
        ),
      ),
    );
  }

  void onSave() {
    final validated = formKey.currentState?.validate() ?? false;
    if (!validated) return;

    final isEdit = widget.childInfo != null;
    final bloc = context.read<SantaListBloc>();
    const uuid = Uuid();

    final childInfo = ChildInfo(
      id: isEdit ? widget.childInfo!.id : uuid.v4(),
      name: nameController.text,
      country: country,
      childType: childType,
    );

    final event =
        isEdit ? SantaChildEdited(childInfo) : SantaChildAdded(childInfo);
    bloc.add(event);
    Navigator.pop(context);
  }

  void onChildTypePick(ChildType? childType) {
    if (childType == null) return;

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

class _PickCountry extends StatelessWidget {
  const _PickCountry(
      {super.key, required this.country, required this.onCountryPick});
  final Country country;
  final VoidCallback onCountryPick;
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      behavior: HitTestBehavior.translucent,
      onTap: onCountryPick,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          const Text('Pick Country'),
          FilledButton.tonal(
            onPressed: onCountryPick,
            child: Text(
              country.name,
            ),
          )
        ],
      ),
    );
  }
}

class _DoneFab extends StatelessWidget {
  const _DoneFab({super.key, required this.onSave, required this.label});
  final VoidCallback onSave;
  final String label;
  @override
  Widget build(BuildContext context) {
    return FloatingActionButton.extended(
      onPressed: onSave,
      icon: const Icon(Icons.save),
      label: Text(
        label,
      ),
    );
  }
}

class _ChildTypeRadios extends StatelessWidget {
  const _ChildTypeRadios(
      {super.key, required this.childType, required this.onChildTypePick});
  final ChildType childType;
  final Function(ChildType? childType) onChildTypePick;
  @override
  Widget build(BuildContext context) {
    return Row(
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
    );
  }
}
