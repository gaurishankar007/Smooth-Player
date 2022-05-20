import 'dart:async';

import 'package:audioplayers/audioplayers.dart';
import 'package:flutter/material.dart';

import '../../resource/player.dart';
import '../../widget/admin_navigator.dart';
import '../../widget/song_bar.dart';

class VerifyArtist extends StatefulWidget {
  const VerifyArtist({Key? key}) : super(key: key);

  @override
  State<VerifyArtist> createState() => _VerifyArtistState();
}

class _VerifyArtistState extends State<VerifyArtist> {
  final AudioPlayer player = Player.player;

  late StreamSubscription stateSub;

  bool songBarVisibility = Player.isPlaying;

  @override
  void initState() {
    super.initState();

    stateSub = player.onPlayerStateChanged.listen((state) {
      setState(() {
        songBarVisibility = Player.isPlaying;
      });
    });
  }

  @override
  void dispose() {
    super.dispose();
    stateSub.cancel();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: SingleChildScrollView(
          child: Column(
            children: const [
              Text("Artist Verification"),
            ],
          ),
        ),
      ),
      floatingActionButton: songBarVisibility
          ? SongBar(
              songData: Player.playingSong,
            )
          : null,
      bottomNavigationBar: AdminPageNavigator(pageIndex: 1),
    );
  }
}
