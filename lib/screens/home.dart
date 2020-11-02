import 'package:aniapp/screens/last.dart';
import 'package:flutter/material.dart';

class Home extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('AniApp')),
      body: AnimeList(),
    );
  }
}
