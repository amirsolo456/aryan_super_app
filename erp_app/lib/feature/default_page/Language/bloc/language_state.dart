import 'package:equatable/equatable.dart';
import 'package:models_package/Data/Default/mng/select/Language/Language.dart';



abstract class LanguageState extends Equatable {
  const LanguageState();


  @override
  List<Object?> get props => [];
}


class LanguageInitial extends LanguageState {
  const LanguageInitial();
}


class LanguageLoading extends LanguageState {
  const LanguageLoading();
}


class LanguageLoaded extends LanguageState {
  final List<ResponseData> languages;
  const LanguageLoaded(this.languages);


  @override
  List<Object?> get props => [languages];
}


class LanguageError extends LanguageState {
  final String? message;
  const LanguageError([this.message]);


  @override
  List<Object?> get props => [message];
}