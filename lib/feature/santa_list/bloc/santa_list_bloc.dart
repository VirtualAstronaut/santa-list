import 'package:bloc/bloc.dart';
import 'package:santa_list/core/models/child_info.dart';

part 'santa_list_event.dart';
part 'santa_list_state.dart';

class SantaListBloc extends Bloc<SantaListEvent, SantaListState> {
  SantaListBloc() : super(const SantaListState()) {
    on<SantaListEvent>((event, emit) {});
  }
}
