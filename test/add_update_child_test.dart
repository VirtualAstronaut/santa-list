import 'package:country_picker/country_picker.dart';
import 'package:santa_list/core/enums/enums.dart';
import 'package:santa_list/core/models/models.dart';
import 'package:santa_list/feature/santa_list/bloc/santa_list_bloc.dart';
import 'package:santa_list/feature/santa_list/santa_list.dart';
import 'package:test/test.dart';
import 'package:bloc_test/bloc_test.dart';

void main() {
  group(SantaListBloc, () {
    late SantaListBloc bloc;
    setUp(() {
      bloc = SantaListBloc();
    });

    test('Initial state SantaListEmpty', () {
      expect(bloc.state, equals(const SantaListData(childInfo: [])));
    });

    final country = CountryService().findByCode('IN');
    final childInfo = ChildInfo(
      name: 'New',
      country: country!,
      childType: ChildType.nice,
      id: '0001',
    );
    final edited = childInfo.copyWith(childType: ChildType.naughty);

    blocTest<SantaListBloc, SantaListState>(
      'Adds and edits a child',
      build: () => bloc,
      act: (bloc) async {
        bloc.add(SantaChildAdded(childInfo));
        bloc.add(SantaChildEdited(edited));
      },
      expect: () => [
        SantaListData(childInfo: [childInfo]),
        SantaListData(childInfo: [edited]),
      ],
    );
  });
}
