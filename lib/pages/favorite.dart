import 'package:flutter/material.dart';

class FavoriteScreen extends StatefulWidget {
  final String imageurl;
  const FavoriteScreen({super.key, required this.imageurl});

  @override
  State<FavoriteScreen> createState() => _FavoriteScreenState();
}

class _FavoriteScreenState extends State<FavoriteScreen> {
  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: Container(child: Container(child: Image.network(widget.imageurl))),
    );
  }
}
