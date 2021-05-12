import 'dart:async';
import 'dart:ui';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:miusu/domain/usecases/get_preferred_language.dart';
import 'package:miusu/domain/usecases/no_params.dart';
import 'package:miusu/domain/usecases/update_language.dart';

import '../../../common/constants/languages.dart';
import '../../../domain/entities/langauge_entity.dart';

part 'language_event.dart';
part 'language_state.dart';

class LanguageBloc extends Bloc<LanguageEvent, LanguageState> {
  final UpdateLanguage updateLanguage;
  final GetPreferredLanguage getPreferredLanguage;

  LanguageBloc({required this.updateLanguage, required this.getPreferredLanguage}) : super(LanguageLoaded(Locale(Languages.languages[0].code)));

  @override
  Stream<LanguageState> mapEventToState(
    LanguageEvent event,
  ) async* {
    if(event is ToggleLanguageEvent) {
      await updateLanguage(event.language.code);
      add(LoadPreferredLanguageEvent());
      // yield LanguageLoaded(Locale(event.language.code));
    }else if(event is LoadPreferredLanguageEvent) {
      final response = await getPreferredLanguage(NoParams());
      yield response.fold((l) => LanguageError(), (r) => LanguageLoaded(Locale(r!)));
    }
  }
}
