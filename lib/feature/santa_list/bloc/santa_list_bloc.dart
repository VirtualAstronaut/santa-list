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
          event.childInfo,
          ...santaListData.childInfo,
        ];
        emit(
          SantaListData(
            childInfo: list,
          ),
        );
        if (state is SantaListData) {
          SantaListData santaListData = state as SantaListData;
          log(santaListData.childInfo.length.toString());
        }
      },
    );
    on<SantaChildEdited>(
      (event, emit) {
        if (state is SantaListEmpty) return;

        SantaListData santaListData = state as SantaListData;
        final indexOfElement = santaListData.childInfo.indexWhere(
          (element) => element.id == event.childInfo.id,
        );

        final list = [...santaListData.childInfo];
        list[indexOfElement] = event.childInfo;

        emit(
          SantaListData(
            childInfo: list,
          ),
        );
      },
    );
  }
}
