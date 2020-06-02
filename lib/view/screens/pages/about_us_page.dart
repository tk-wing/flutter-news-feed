import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/material.dart';

class AboutUsPage extends StatefulWidget {
  @override
  _AboutUsPageState createState() => _AboutUsPageState();
}

class _AboutUsPageState extends State<AboutUsPage> {
  bool _selected = false;
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        body: Center(
            child: AnimatedContainer(
          width: _selected ? 300 : 0,
          height: _selected ? 200 : 0,
          child: AutoSizeText(
            'News Feed App',
            style: TextStyle(fontSize: 40.0),
            minFontSize: 6.0,
            maxLines: 1,
            overflow: TextOverflow.clip,
          ),
          alignment: _selected ? Alignment.center : Alignment.topCenter,
          duration: Duration(milliseconds: 1000),
          curve: Curves.fastOutSlowIn,
        )),
        floatingActionButton: FloatingActionButton(
          child: Icon(Icons.play_arrow),
          tooltip: '再生',
          onPressed: () {
            setState(() {
              _selected = !_selected;
            });
          },
        ),
      ),
    );
  }
}
