import 'package:audioplayer/audioplayer.dart';
import 'package:flutter/material.dart';
import 'package:nihongo_courses/models/word.dart';
import 'package:nihongo_courses/utils/api_helper.dart';
import 'package:nihongo_courses/utils/audio_provider.dart';

class StepPage extends StatefulWidget {
  @override
  _StepPageState createState() => _StepPageState();
}

class _StepPageState extends State<StepPage> {
  String _partOfSpeech, _secTitle, _category;
  int _limit, _offset;
  bool _showParts;

  List<WordItem> _words;

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
    print(args["title"]);

    return Scaffold(
      appBar: AppBar(
        title: Text(_secTitle),
        centerTitle: true,
        backgroundColor: Colors.indigoAccent,
        elevation: 0,
      ),
      body: Container(
        width: double.infinity,
        height: double.infinity,
        color: Colors.indigoAccent,
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
              return Center(child: CircularProgressIndicator());
            }
          },
        ),
      ),
      floatingActionButton: FloatingActionButton(
        backgroundColor: Colors.red,
        child: Icon(Icons.play_arrow),
        onPressed: () {
          Navigator.of(context).pushNamed(
            "/session",
            arguments: {"words": _words, "category": _category},
          );
        },
      ),
    );
  }

  //TODO: show word details
  // TODO: aggiungere pulsante revisione

  Widget buildListView(List<WordItem> words) {
    return ListView.builder(
      padding: EdgeInsets.fromLTRB(8, 8, 8, 50),
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
    wordText.add(Text(item.word.traduction));

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
            crossAxisAlignment: CrossAxisAlignment.stretch,
            mainAxisSize: MainAxisSize.max,
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: <Widget>[
              Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: wordText,
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
