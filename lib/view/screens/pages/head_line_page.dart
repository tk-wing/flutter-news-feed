import 'package:flutter/material.dart';

class HeadLinePage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return SafeArea(
          child: Scaffold(
        body: Center(
          child: Container(
            child: Text('ヘッドラインページ'),
          ),
        ),
      ),
    );
  }
}
