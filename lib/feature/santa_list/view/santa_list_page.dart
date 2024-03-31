import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:santa_list/core/models/models.dart';
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
          body: switch (state) {
            SantaListEmpty() =>
              const Center(child: Text('Nothing Added Yet...')),
            SantaListData() => _ChildrenListView(data: state.childInfo),
          },
        );
      },
    );
  }

  void onChildAddPressed(BuildContext context) {
    final bloc = context.read<SantaListBloc>();
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => AddChildpage(bloc: bloc),
      ),
    );
  }
}

class _ChildrenListView extends StatelessWidget {
  const _ChildrenListView({super.key, required this.data});
  final List<ChildInfo> data;
  @override
  Widget build(BuildContext context) {
    return ListView.separated(
      itemCount: data.length,
      padding: const EdgeInsets.all(16),
      separatorBuilder: (context, index) => const SizedBox(height: 10),
      itemBuilder: (context, index) => ChildListTile(
        data: data[index],
        onTap: () => onTileTap(context, data[index]),
      ),
    );
  }

  void onTileTap(BuildContext context, ChildInfo data) {
    final bloc = context.read<SantaListBloc>();
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => AddChildpage(
          bloc: bloc,
          childInfo: data,
        ),
      ),
    );
  }
}
