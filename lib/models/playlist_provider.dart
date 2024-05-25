import 'package:audioplayers/audioplayers.dart';
import 'package:flutter/material.dart';
import 'package:music_app/models/song.dart';

class PlaylistProvider extends ChangeNotifier {
  final List<Song> _playlist = [
    Song(
        songName: "Sajni",
        artisName: "Arijit Singh",
        albumArtImagePath: "assets/images/music.png",
        audioPath: "audio/music.mp3"),
    Song(
        songName: "Kahani Meri",
        artisName: "kaifi Khalil",
        albumArtImagePath: "assets/images/music2.png",
        audioPath: "audio/music2.mp3"),
    Song(
        songName: "Naina",
        artisName: "Diljit Dosanjh",
        albumArtImagePath: "assets/images/music3.png",
        audioPath: "audio/music3.mp3"),
  ];

// Current Song playing index

  int? _currentSongIndex;

  /*
  Audio player
   */

  // audio player
  final AudioPlayer _audioPlayer = AudioPlayer();
  // durations
  Duration _currentDuration = Duration.zero;
  Duration _totalDuration = Duration.zero;

  // constructor
  PlaylistProvider(){
    listenToDuration();
  }
  // initially not playing
  bool _isPlaying = false;
  //play the song
  void play() async{
    final String path = _playlist[currentSongIndex!].audioPath;
    await _audioPlayer.stop();
    await _audioPlayer.play(AssetSource(path));
    _isPlaying = true;
    notifyListeners();
  }
  // pause current song
  void pause() async{
    await _audioPlayer.pause();
    _isPlaying = false;
    notifyListeners();
  }
  // resume playing
  void resume() async{
    await _audioPlayer.resume();
    _isPlaying = true;
    notifyListeners();
  }
  // pause or resume
  void pauseOrResume() async{
    if(_isPlaying){
      pause();
    }
    else{
      resume();
    }
  }
  // seek to specific position
  void seek(Duration position) async{
    await _audioPlayer.seek(position);
  }
  // play next song
  void playNextSong() {
    if(_currentSongIndex !=null){
      if(_currentSongIndex! < _playlist.length - 1){
        currentSongIndex = _currentSongIndex! + 1;
      }
      else{
        currentSongIndex = 0;
      }
    }
  }
  // play previous song
  void playPreviousSong() async{
    if(_currentDuration.inSeconds > 2){
          seek(Duration.zero);
    } else{
      if(_currentSongIndex! > 0){
        currentSongIndex = _currentSongIndex! - 1;
      } else {
        currentSongIndex = _playlist.length  -1;
      }
    }
  }
  // listen to duration
  void listenToDuration() {
    _audioPlayer.onDurationChanged.listen((newDuration) {
      _totalDuration = newDuration;
      notifyListeners();
    } );

    _audioPlayer.onPositionChanged.listen((newPostion){
      _currentDuration = newPostion;
      notifyListeners();
    });

    _audioPlayer.onPlayerComplete.listen((event){
      playNextSong();
    });
  }
  // dispose the player
  List<Song> get getPlaylist => _playlist;
  int? get currentSongIndex => _currentSongIndex;
  bool get isPlaying => _isPlaying;
  Duration get currentDuration => _currentDuration;
  Duration get totalDuration  => _totalDuration;

  set currentSongIndex(int? newIndex){
    _currentSongIndex = newIndex;

    if(newIndex != null){
      play();
    }
    notifyListeners();
  }
}
