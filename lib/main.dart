import 'package:flutter/material.dart';
import 'package:melophile/pages/music_list.dart';

void main() {
  runApp(Melophile());
}

class Melophile extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: MusicList(),
    );
  }
}
