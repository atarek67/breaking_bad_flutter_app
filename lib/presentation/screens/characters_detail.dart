import 'dart:math';
import 'package:animated_text_kit/animated_text_kit.dart';
import '../../business_logic/cubit/characters_cubit_cubit.dart';
import '../../constants/my_colors.dart';
import '../../data/models/character.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class CharacterDetailScreen extends StatelessWidget {
  final Character character;
  const CharacterDetailScreen({Key? key, required this.character})
      : super(key: key);

  Widget characterInfo(String title, String value) {
    return RichText(
      maxLines: 1,
      overflow: TextOverflow.ellipsis,
      text: TextSpan(children: [
        TextSpan(
          text: title,
          style: const TextStyle(
              color: MyColors.myWhite,
              fontWeight: FontWeight.bold,
              fontSize: 15),
        ),
        TextSpan(
          text: value,
          style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 13),
        ),
      ]),
    );
  }

  Widget buildDivider(double endIndent) {
    return Divider(
      color: MyColors.myYellow,
      height: 30.0,
      endIndent: endIndent,
      thickness: 15.0,
    );
  }

  Widget buildSliverAppBar() {
    return SliverAppBar(
      expandedHeight: 550,
      pinned: true,
      stretch: true,
      backgroundColor: MyColors.myGrey,
      flexibleSpace: FlexibleSpaceBar(
        centerTitle: true,
        title: Text(
          character.nickName,
          style: const TextStyle(color: MyColors.myWhite),
          textAlign: TextAlign.start,
        ),
        background: Hero(
          tag: character.charId,
          child: Image.network(
            character.image,
            fit: BoxFit.cover,
          ),
        ),
      ),
    );
  }

  Widget checkIfQuotesAreLoaded(CharactersCubitState state) {
    if (state is QuotesLoaded) {
      return displayRandomQuoteOrEmptySpace(state);
    } else {
      return showProgressIndicator();
    }
  }

  Widget displayRandomQuoteOrEmptySpace(state) {
    var quotes = (state).quotes;
    if (quotes.length != 0) {
      int randomQuoteIndex = Random().nextInt(quotes.length - 1);
      return Center(
        child: DefaultTextStyle(
          textAlign: TextAlign.center,
          style: const TextStyle(
              color: MyColors.myWhite,
              fontSize: 20.0,
              shadows: [
                Shadow(
                  blurRadius: 7,
                  offset: Offset(0, 0),
                  color: MyColors.myYellow,
                )
              ]),
          child: AnimatedTextKit(
            repeatForever: true,
            animatedTexts: [
              FlickerAnimatedText(quotes[randomQuoteIndex].quote),
            ],
          ),
        ),
      );
    } else {
      return Container();
    }
  }

  Widget showProgressIndicator() {
    return const Center(
      child: CircularProgressIndicator(
        color: MyColors.myYellow,
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    BlocProvider.of<CharactersCubit>(context).getQuotes(character.name);
    return Scaffold(
      backgroundColor: MyColors.myGrey,
      body: CustomScrollView(
        slivers: [
          buildSliverAppBar(),
          SliverList(
              delegate: SliverChildListDelegate([
            Container(
              margin: const EdgeInsets.fromLTRB(8, 8, 8, 8),
              padding: const EdgeInsets.all(10),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  characterInfo("Job: ", character.jobs.join(' / ')),
                  buildDivider(315),
                  characterInfo(
                      "Appeared in: ", character.categoryForTwoSeries),
                  buildDivider(265),
                  characterInfo(
                      "Seasons: ", character.appearanceOfSeasons.join(' / ')),
                  buildDivider(290),
                  characterInfo("Status ", character.statusIfDeadOrAlive),
                  buildDivider(300),
                  character.betterCallSaulAppearance.isEmpty
                      ? Container()
                      : buildDivider(280),
                  characterInfo("Better Call Soul: ",
                      character.betterCallSaulAppearance.join(" / ")),
                  character.betterCallSaulAppearance.isEmpty
                      ? Container()
                      : buildDivider(280),
                  characterInfo("Actor/Actress: ", character.acotrName),
                  buildDivider(250),
                  const SizedBox(
                    height: 20,
                  ),
                  BlocBuilder<CharactersCubit, CharactersCubitState>(
                    builder: (context, state) {
                      return checkIfQuotesAreLoaded(state);
                    },
                  ),
                ],
              ),
            ),
            const SizedBox(
              height: 350,
            )
          ])),
        ],
      ),
    );
  }
}
