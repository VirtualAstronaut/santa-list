import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:santa_list/feature/santa_list/view/add_child_page.dart';
import 'package:santa_list/feature/santa_list/view/widgets/child_list_tile.dart';

import '../santa_list.dart';

class SantaListPage extends StatelessWidget {
  const SantaListPage({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (_) => SantaListBloc(),
      child: const SantaListView(),
    );
  }
}

class SantaListView extends StatelessWidget {
  const SantaListView({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<SantaListBloc, SantaListState>(
      builder: (context, state) {
        return Scaffold(
          floatingActionButton: FloatingActionButton.extended(
            onPressed: () => onChildAddPressed(context),
            icon: const Icon(Icons.add),
            label: const Text(
              'Add Child',
            ),
          ),
          appBar: AppBar(
            title: const Text('Santa children list'),
          ),
          body: const _ChildrenListView(),
        );
      },
    );
  }

  void onChildAddPressed(BuildContext context) {
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => const AddChildpage(),
      ),
    );
  }
}

class _ChildrenListView extends StatelessWidget {
  const _ChildrenListView({super.key});

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      itemBuilder: (context, index) => const ChildListTile(),
    );
  }
}
