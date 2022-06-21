part of 'characters_cubit_cubit.dart';

@immutable
abstract class CharactersCubitState {
  get charQuote => null;
}

class CharactersCubitInitial extends CharactersCubitState {}

class CharactersLoaded extends CharactersCubitState {
  final List<Character> characters;
  CharactersLoaded(this.characters);
}

class QuotesLoaded extends CharactersCubitState {
  final List<Quote> quotes;
  QuotesLoaded(this.quotes);
}
