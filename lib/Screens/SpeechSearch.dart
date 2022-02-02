

import 'package:avatar_glow/avatar_glow.dart';
import 'package:flutter/material.dart';
import 'package:highlight_text/highlight_text.dart';
import 'package:speech_to_text/speech_to_text.dart' as stt;

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Voice',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        primarySwatch: Colors.red,
        visualDensity: VisualDensity.adaptivePlatformDensity,
      ),
      home: SpeechSearch(),
    );
  }
}

class SpeechSearch extends StatefulWidget {
  @override
  _SpeechSearchState createState() => _SpeechSearchState();
}

class _SpeechSearchState extends State<SpeechSearch> {
  final Map<String, HighlightedWord> _highlights = {
    'flutter': HighlightedWord(
      onTap: () => print('flutter'),
      textStyle: const TextStyle(
        color: Colors.blue,
        fontWeight: FontWeight.bold,
      ),
    ),
    'voice': HighlightedWord(
      onTap: () => print('voice'),
      textStyle: const TextStyle(
        color: Colors.green,
        fontWeight: FontWeight.bold,
      ),
    ),
    'subscribe': HighlightedWord(
      onTap: () => print('subscribe'),
      textStyle: const TextStyle(
        color: Colors.red,
        fontWeight: FontWeight.bold,
      ),
    ),
    'like': HighlightedWord(
      onTap: () => print('like'),
      textStyle: const TextStyle(
        color: Colors.blueAccent,
        fontWeight: FontWeight.bold,
      ),
    ),
    'comment': HighlightedWord(
      onTap: () => print('comment'),
      textStyle: const TextStyle(
        color: Colors.green,
        fontWeight: FontWeight.bold,
      ),
    ),
  };

  stt.SpeechToText _speech;
  bool _isListening = false;
  String SearchResult;
  // List<String> SearchResult = [
  //
  // ];
  List<String> Search = [
    'Bismillah hir Rahmaan Nir Raheem',
    'alhamdulillahi Rabbil aalameen',
    'Ar Rahmaanir Raheem',
    'Mali ki Yawmid-Deen',
    'Ihdinas-Siraatal-Mustaqeem',
    'Alif laam Meeem',
    'zalikal Kitaabu laa raiba feeh hudal lilmuttaqeen',
  ];
  String _text;
  double _confidence = 1.0;

  @override
  void initState() {
    super.initState();
    setState(() {
      SearchResult;
    });
    _speech = stt.SpeechToText();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Confidence: ${(_confidence * 100.0).toStringAsFixed(1)}%'),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
      floatingActionButton: AvatarGlow(
        animate: _isListening,
        glowColor: Theme.of(context).primaryColor,
        endRadius: 75.0,
        duration: const Duration(milliseconds: 2000),
        repeatPauseDuration: const Duration(milliseconds: 100),
        repeat: true,
        child: FloatingActionButton(
          onPressed: _listen,
          child: Icon(_isListening ? Icons.mic : Icons.mic_none),
        ),
      ),
      body: SingleChildScrollView(
          reverse: true,
          child: Expanded(

            child: Container(
              height: 500,
              width: 500,
              child:  Column(
                children: [
                  Text(_text??"Please Voice Search Verse (Surah) "),

                  Text(SearchResult.toString()??"No Verse (Surah) Found)",style: TextStyle(color: Colors.black),),
                ],
              ),
            ),
          )
        // child: Container(
        //   padding: const EdgeInsets.fromLTRB(30.0, 30.0, 30.0, 150.0),
        //   child: TextHighlight(
        //     text: _text.toString(),
        //     words: _highlights,
        //     textStyle: const TextStyle(
        //       fontSize: 32.0,
        //       color: Colors.black,
        //       fontWeight: FontWeight.w400,
        //     ),
        //   ),
        // ),
      ),
    );
  }

  bool _isSearch = false;
  void _listen() async {
    if (!_isListening) {
      bool available = await _speech.initialize(
        onStatus: (val) => print('onStatus: $val'),
        onError: (val) => print('onError: $val'),
      );
      if (available) {
        setState(() => _isListening = true);
        _speech.listen(
          onResult: (val) => setState(() {
            _text = val.recognizedWords;

            if (val.hasConfidenceRating && val.confidence > 0) {
              _confidence = val.confidence;
              searchOperation(_text);
            }
          }),
        );
      }
    } else {
      setState(() => _isListening = false);
      _speech.stop();
    }
  }

  void searchOperation(String _text) {

    //  if (_isSearch != null) {.
    for (int i = 0; i < Search.length; i++) {
      String data = Search.elementAt(i);
      if (data.toLowerCase().contains(_text.toLowerCase())) {
        SearchResult="";
        SearchResult=data;
      }else{

        Text('No data found');
      }
    }
  }
}

