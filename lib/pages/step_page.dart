import 'package:audioplayer/audioplayer.dart';
import 'package:flutter/material.dart';
import 'package:nihongo_courses/models/word.dart';
import 'package:nihongo_courses/utils/api_helper.dart';
import 'package:nihongo_courses/utils/audio_provider.dart';
import 'package:nihongo_courses/theme.dart' as Theme;
import 'package:nihongo_courses/utils/no_overscroll_behavior.dart';

class StepPage extends StatefulWidget {
  @override
  _StepPageState createState() => _StepPageState();
}

class _StepPageState extends State<StepPage> {
  String _partOfSpeech, _secTitle, _category;
  int _limit, _offset;
  bool _showParts;

  List<WordItem> _words;

  var key = GlobalKey<ToolbarState>();

  @override
  Widget build(BuildContext context) {
    final Map args = ModalRoute.of(context).settings.arguments;
    _offset = args["offset"];
    _limit = args["limit"];
    _partOfSpeech = args["partOfSpeech"];
    _secTitle = args["section_title"];
    _category =
        args["course_title"] == "Categories" ? args["section_category"] : null;
    _showParts = args["title"] != "Categories";

    return Scaffold(
      body: Container(
        constraints: BoxConstraints.expand(),
        child: Stack(
          children: <Widget>[
            _buildContent(),
            Toolbar(_secTitle, scrollController: _scrollController, key: key),
          ],
        ),
      ),
    );
  }

  Container _buildContent() {
    return Container(
      decoration: BoxDecoration(
        gradient: LinearGradient(
          colors: [
            Theme.Colors.appBarGradientStart,
            Theme.Colors.appBarGradientEnd,
          ],
          stops: [0.0, 1.0],
          begin: const FractionalOffset(0.0, 0.0),
          end: const FractionalOffset(0.0, 1.0),
        ),
      ),
      padding: EdgeInsets.only(top: 72.0),
      child: Column(
        children: <Widget>[
          Flexible(
            child: FutureBuilder(
              future: ApiHelper.instance.getWords(
                partOfSpeech: _partOfSpeech,
                offset: _offset,
                limit: _limit,
                category: _category,
              ),
              builder: (BuildContext context, AsyncSnapshot snapshot) {
                if (snapshot.connectionState == ConnectionState.done &&
                    snapshot.hasData) {
                  _words = snapshot.data;
                  return buildListView(snapshot.data ?? []);
                } else {
                  return Center(
                      child: CircularProgressIndicator(
                    valueColor: AlwaysStoppedAnimation<Color>(
                      Colors.yellowAccent,
                    ),
                  ));
                }
              },
            ),
          ),
          Container(
            width: double.infinity,
            color: Theme.Colors.button,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: <Widget>[
                LinearProgressIndicator(
                  valueColor: AlwaysStoppedAnimation<Color>(
                    Colors.yellowAccent,
                  ),
                  value: 0.3,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: <Widget>[
                    FlatButton(
                      padding: const EdgeInsets.all(16.0),
                      shape: ContinuousRectangleBorder(),
                      textColor: Theme.Colors.common,
                      child: Text("REVISION"),
                      onPressed: () => null,
                    ),
                    FlatButton(
                      padding: const EdgeInsets.all(16.0),
                      shape: ContinuousRectangleBorder(),
                      textColor: Theme.Colors.common,
                      child: Text("NEW WORDS"),
                      onPressed: () {
                        Navigator.of(context).pushNamed(
                          "/session",
                          arguments: {"words": _words, "category": _category},
                        );
                      },
                    ),
                  ],
                ),
              ],
            ),
          )
        ],
      ),
    );
  }

  //TODO: show word details
  // TODO: aggiungere pulsante revisione

  ScrollController _scrollController = ScrollController();

  Widget buildListView(List<WordItem> words) {
    return ScrollConfiguration(
      behavior: NoOverScrollBehavior(),
      child: ListView.builder(
        controller: _scrollController,
        padding: EdgeInsets.all(8.0),
        itemCount: words.length,
        itemBuilder: (BuildContext context, int index) {
          return GestureDetector(
            child: buildItem(words[index]),
            onTap: () async {
              String url = words[index].word.audio;
              AudioPlayer audioPlayer = new AudioPlayer();
              AudioProvider audioProvider = new AudioProvider(url);

              String localUrl = await audioProvider.load();
              audioPlayer.play(localUrl, isLocal: true);
            },
          );
        },
      ),
    );
  }

  // TODO: assegnare una percentuale ad ogni word in base agli errori...

  Widget buildItem(WordItem item) {
    var style = TextStyle(fontWeight: FontWeight.bold, fontSize: 18);
    var wordText = <Widget>[];
    if (item.word.kanji != null) {
      wordText.add(Text(item.word.kanji, style: style));
      wordText.add(Text(item.word.kana));
    } else {
      wordText.add(Text(item.word.kana, style: style));
    }
    wordText.add(Text(
      item.word.traduction,
      overflow: TextOverflow.ellipsis,
    ));

    var pos = Container();
    if (_showParts)
      pos = Container(
        child: Text(
          item.word.partOfSpeech,
          style: TextStyle(color: Colors.white),
        ),
        padding: EdgeInsets.all(8),
        decoration: ShapeDecoration(
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(8),
          ),
          color: Colors.green,
        ),
      );

    return Container(
      height: 100,
      width: double.infinity,
      child: Card(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 16.0),
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: <Widget>[
              Flexible(
                child: Padding(
                  padding: const EdgeInsets.only(right: 16.0),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.stretch,
                    children: wordText,
                  ),
                ),
              ),
              Column(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.end,
                children: <Widget>[
                  pos,
                ],
              )
            ],
          ),
        ),
      ),
    );
  }
}

class Toolbar extends StatefulWidget {
  final String title;
  final ScrollController scrollController;
  final Key key;

  Toolbar(this.title, {this.scrollController, this.key}) : super(key: key);

  @override
  ToolbarState createState() => ToolbarState();
}

class ToolbarState extends State<Toolbar> {
  var _shadow = false;

  _listener() {
    var newShadow = widget.scrollController.offset > 4.0;

    if (_shadow != newShadow) {
      setState(() {
        _shadow = newShadow;
      });
    }
  }

  @override
  initState() {
    super.initState();
    widget.scrollController.addListener(_listener);
  }

  @override
  dispose() {
    widget.scrollController.removeListener(_listener);
    widget.scrollController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final row = Row(
      children: <Widget>[
        BackButton(color: Theme.Colors.appBarIconColor),
        Expanded(
          child: Text(
            widget.title,
            style: Theme.TextStyles.appBarTitle,
            textAlign: TextAlign.center,
          ),
        ),
        IconButton(
          icon: Icon(Icons.restore),
          color: Theme.Colors.appBarIconColor,
          tooltip: "Reset",
          onPressed: () {
            // reset ...
          },
        ),
      ],
    );

    if (_shadow && widget.scrollController != null) {
      return Material(
        color: Colors.transparent,
        elevation: 4,
        child: Container(
          padding: EdgeInsets.only(top: MediaQuery.of(context).padding.top),
          color: Theme.Colors.appBarGradientStart,
          child: row,
        ),
      );
    }

    return Container(
      padding: EdgeInsets.only(top: MediaQuery.of(context).padding.top),
      child: row,
    );
  }
}
