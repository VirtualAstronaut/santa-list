import 'package:country_picker/country_picker.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:santa_list/core/enums/child_type.dart';
import 'package:santa_list/core/models/models.dart';
import 'package:santa_list/feature/santa_list/bloc/santa_list_bloc.dart';
import 'package:santa_list/shared/shared.dart';
import 'package:santa_list/shared/utils.dart';
import 'package:santa_list/shared/widgets/radio_item.dart';

class AddChildpage extends StatefulWidget {
  const AddChildpage({super.key});

  @override
  State<AddChildpage> createState() => _AddChildpageState();
}

class _AddChildpageState extends State<AddChildpage> {
  final data = ValueNotifier<ChildInfo?>(null);
  @override
  Widget build(BuildContext context) {
    return BlocProvider(create: (context) => SantaListBloc(), child: _Body());
  }

  void onFabTap() {
    final bodyState = context.findRootAncestorStateOfType<_BodyState>();
    if (bodyState == null) return;

    final valited = bodyState.formKey.currentState?.validate() ?? false;
    if (!valited) return;
    final childInfo = ChildInfo(
      name: bodyState.nameController.text,
      country: bodyState.country,
      childType: bodyState.childType,
    );
    final bloc = context.read<SantaListBloc>();
    bloc.add(SantaChildAdded(childInfo));
  }

  void onSave(ChildInfo childInfo) {}
}

class _Body extends StatefulWidget {
  const _Body({
    super.key,
  });

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
    nameController = TextEditingController();
    final country = CountryService().findByCode('IN');
    if (country != null) {
      this.country = country;
    }
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Add Child'),
      ),
      floatingActionButton: _DoneFab(
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
              Row(
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

    final childInfo = ChildInfo(
      name: nameController.text,
      country: country,
      childType: childType,
    );
    final bloc = context.read<SantaListBloc>();
    bloc.add(SantaChildAdded(childInfo));

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

class _DoneFab extends StatelessWidget {
  const _DoneFab({super.key, required this.onSave});
  final VoidCallback onSave;
  @override
  Widget build(BuildContext context) {
    return FloatingActionButton.extended(
      onPressed: onSave,
      icon: const Icon(Icons.save),
      label: const Text('Save'),
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
