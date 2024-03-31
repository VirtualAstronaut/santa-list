import 'dart:developer';

import 'package:flutter/foundation.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:santa_list/core/models/child_info.dart';

part 'santa_list_event.dart';
part 'santa_list_state.dart';

class SantaListBloc extends Bloc<SantaListEvent, SantaListState> {
  SantaListBloc() : super(const SantaListData(childInfo: [])) {
    on<SantaChildAdded>(
      (event, emit) {
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
      },
    );
    on<SantaChildEdited>(
      (event, emit) {
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
