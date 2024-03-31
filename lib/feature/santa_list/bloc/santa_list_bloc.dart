import 'dart:developer';

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:santa_list/core/models/child_info.dart';

part 'santa_list_event.dart';
part 'santa_list_state.dart';

class SantaListBloc extends Bloc<SantaListEvent, SantaListState> {
  SantaListBloc() : super(const SantaListEmpty()) {
    on<SantaChildAdded>(
      (event, emit) {
        if (state is SantaListEmpty) {
          emit(SantaListData(childInfo: []));
        }
        SantaListData santaListData = state as SantaListData;
        final list = [
          ...santaListData.childInfo,
          event.childInfo,
        ];
        emit(
          SantaListData(
            childInfo: list,
          ),
        );
      },
    );
  }
}
