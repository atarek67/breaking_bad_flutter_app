// ignore: depend_on_referenced_packages
import 'package:bloc/bloc.dart';
import 'package:breaking_bad_flutter/data/models/character.dart';
import 'package:breaking_bad_flutter/data/models/quote.dart';
import 'package:breaking_bad_flutter/data/repository/characters.repository.dart';
// ignore: depend_on_referenced_packages
import 'package:meta/meta.dart';

part 'characters_cubit_state.dart';

class CharactersCubit extends Cubit<CharactersCubitState> {
  late CharactersRepository charactersRepository;
  List<Character> characters = [];

  CharactersCubit(this.charactersRepository) : super(CharactersCubitInitial());

  List<Character> getAllCharacters() {
    charactersRepository.getAllCharacters().then((character) {
      emit(CharactersLoaded(character));
      characters = characters;
    });

    return characters;
  }

  void getQuotes(String charName) {
    charactersRepository.getCharacterQuotes(charName).then((quotes) {
      emit(QuotesLoaded(quotes));
    });
  }
}
