import 'package:flutter/material.dart';

class FilmBorder extends StatelessWidget {
  final int value;
  const FilmBorder({Key key, this.value = 0})
      : assert(value != null),
        super(key: key);
  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
          image: DecorationImage(image: AssetImage("assets/film.jpeg"),fit: BoxFit.fill)
      ),
    );
  }
}