import 'package:audioplayer/audioplayer.dart';
import 'package:flutter/material.dart';
import 'package:nihongo_courses/models/word.dart';
import 'package:nihongo_courses/utils/audio_provider.dart';
import 'package:nihongo_courses/utils/icons.dart';
import 'package:nihongo_courses/theme.dart' as Theme;
import 'package:nihongo_courses/utils/no_overscroll_behavior.dart';
import 'package:nihongo_courses/widgets/highlight_text.dart';

class WordItemDetails extends StatefulWidget {
  WordItemDetails(this.item);

  final WordItem item;

  @override
  _WordItemDetailsState createState() => _WordItemDetailsState();
}

class _WordItemDetailsState extends State<WordItemDetails> {
  WordItem get item => widget.item;

  AudioPlayer audioPlayer = AudioPlayer();
  AudioProvider audioProvider;

  _playAudio(url) async {
    audioProvider = AudioProvider(url);
    String localUrl = await audioProvider.load();
    audioPlayer.play(localUrl, isLocal: true);
  }

  @override
  Widget build(BuildContext context) {
    var children = <Widget>[];

    if (item.word.kanji != null) {
      children.add(Text(
        item.word.kana,
        style: Theme.TextStyles.subtitle,
      ));
    }

    children.add(Text(
      item.word.kanji ?? item.word.kana,
      style: Theme.TextStyles.title,
    ));

    children.add(Padding(
      padding: const EdgeInsets.symmetric(vertical: 16.0),
      child: Text(
        item.word.traduction,
        style: Theme.TextStyles.common,
      ),
    ));

    var sentences = <Widget>[];

    sentences.add(Padding(
      padding: const EdgeInsets.symmetric(vertical: 16.0),
      child: Text(
        "SENTENCES",
        style: Theme.TextStyles.header,
      ),
    ));

    sentences.add(Container(
      color: Theme.Colors.accent,
      height: 2,
      width: 180,
    ));

    item.sentences.forEach((s) {
      sentences.add(Padding(
        padding: const EdgeInsets.symmetric(vertical: 16.0),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.start,
          children: <Widget>[
            Padding(
              padding: const EdgeInsets.only(right: 16.0),
              child: GestureDetector(
                child: Icon(MyIcons.volume_up, color: Theme.Colors.icon),
                onTap: () => _playAudio(s.audio),
              ),
            ),
            Flexible(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  HighlightedText(
                    s.kanji.replaceAll(" ", ""),
                    Theme.Colors.common,
                    Theme.Colors.highlight,
                  ),
                  HighlightedText(
                    s.kana.replaceAll(" ", ""),
                    Theme.Colors.common,
                    Theme.Colors.highlight,
                  ),
                  SizedBox(height: 8),
                  Text(s.traduction, style: Theme.TextStyles.common),
                ],
              ),
            ),
          ],
        ),
      ));
    });

    return ScrollConfiguration(
      behavior: NoOverScrollBehavior(),
      child: ListView(
        padding: EdgeInsets.only(top: 72.0),
        children: <Widget>[
          Container(
            height: 250,
            padding: EdgeInsets.all(16.0),
            child: Card(
              color: Theme.Colors.card,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.all(Radius.circular(16)),
              ),
              elevation: 4,
              child: Padding(
                padding: const EdgeInsets.all(16.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: children,
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: <Widget>[
                        Container(
                          padding: EdgeInsets.all(8),
                          decoration: ShapeDecoration(
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(8),
                            ),
                            color: Theme.Colors.tag,
                          ),
                          child: Text(
                            item.word.partOfSpeech,
                            style: Theme.TextStyles.common,
                          ),
                        ),
                        GestureDetector(
                          child: Icon(
                            MyIcons.volume_up,
                            color: Theme.Colors.icon,
                          ),
                          onTap: () => _playAudio(item.word.audio),
                        )
                      ],
                    )
                  ],
                ),
              ),
            ),
          ),
          Container(
            padding: EdgeInsets.fromLTRB(32.0, 0.0, 32.0, 16.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: sentences,
            ),
          )
        ],
      ),
    );
  }
}
