import 'package:flutter/material.dart';
import 'package:music_app/components/my_drawer.dart';
import 'package:music_app/components/neu_box.dart';
import 'package:music_app/models/playlist_provider.dart';
import 'package:provider/provider.dart';
import 'package:velocity_x/velocity_x.dart';


class SongPage extends StatelessWidget {
  const SongPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Consumer<PlaylistProvider>(
      builder: (context,value, child) {
        // get Playlist
        final playlist = value.getPlaylist;
        // get current song
        final currentSong = playlist[value.currentSongIndex ?? 0];
        return  Scaffold(
            backgroundColor: Theme.of(context).colorScheme.background,
            body: SafeArea(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  // app bar
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      // back button
                      IconButton(onPressed: (){
                        Navigator.pop(context);
                      }, icon: const Icon(Icons.arrow_back)),
                      // title
                      const Text('P L A Y L I S T'),
                      // menu button
                      IconButton(onPressed: (){}, icon: const Icon(Icons.menu)),
                    ],
                  ),
                  // album artwork
                  NeuBox(child: Column(
                    children: [
                      ClipRRect(
                          borderRadius: BorderRadius.circular(8),
                          child: Image.asset(currentSong.albumArtImagePath)),
                       Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          // song and artist name
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(currentSong.songName,
                                style: TextStyle(
                                  fontWeight: FontWeight.bold,
                                  fontSize: 20,
                                ),),
                              Text(currentSong.artisName)
                            ],
                          ),
                          Icon(Icons.favorite, color: Colors.red,)
                        ],
                      )
                    ],
                  )),
                  // song duration progress
                  25.heightBox,
                  Column(
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(value.currentDuration.toHumanizedString()),

                          Icon(Icons.shuffle),

                          Icon(Icons.repeat),

                          Text(value.totalDuration.toHumanizedString())
                        ],
                      ).pSymmetric(h: 25),
                      SliderTheme(
                        data: SliderTheme.of(context).copyWith(
                            thumbShape: const RoundSliderThumbShape(
                                enabledThumbRadius: 0
                            )
                        ),
                        child: Slider(
                            min: 0,
                            max: value.totalDuration.inSeconds.toDouble(),
                            activeColor: Colors.green.shade400,
                            value: value.currentDuration.inSeconds.toDouble(),
                          onChanged: (double double){

                        },
                        onChangeEnd: (double double){
                              value.seek(Duration(seconds: double.toInt()));
                        },),
                      )
                    ],
                  ),
                  10.heightBox,
                  // playback controls
                  Row(children: [
                    // skip previous
                    Expanded(child: GestureDetector(
                        onTap: value.playPreviousSong,
                        child: const NeuBox(child: Icon(Icons.skip_previous)))),
                    25.widthBox,
                    // play pause
                    Expanded(
                        flex: 2,
                        child: GestureDetector(
                            onTap: value.pauseOrResume,
                            child:NeuBox(child: Icon(
                                value.isPlaying ? Icons.pause : Icons.play_arrow)))),
                    // skip forward
                    25.widthBox,
                    Expanded(child: GestureDetector(
                        onTap: value.playNextSong,
                        child:const  NeuBox(child: Icon(Icons.skip_next)))),
                  ],)
                ],
              ).pOnly(left: 25, right: 25, bottom: 25),
            )
        );
      }

    );
  }
}
