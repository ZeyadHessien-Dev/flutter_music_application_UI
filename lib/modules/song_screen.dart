import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:just_audio/just_audio.dart';
import 'package:music_application/models/songs_model.dart';
import '../widgets/seek_bar.dart';
import 'package:rxdart/rxdart.dart' as rxdart;

AudioPlayer audioPlayer = AudioPlayer();

Stream<SeekBarData> get _seekBarDataStream =>
    rxdart.Rx.combineLatest2<Duration, Duration?, SeekBarData>(
        audioPlayer.positionStream, audioPlayer.durationStream,
        (Duration position, Duration? duration) {
      return SeekBarData(
        position: position,
        duration: duration ?? Duration.zero,
      );
    });

class SongScreen extends StatefulWidget {
  SongScreen({Key? key}) : super(key: key);

  @override
  State<SongScreen> createState() => _SongScreenState();
}

class _SongScreenState extends State<SongScreen> {
  SongsModel song = Get.arguments ?? SongsModel.songs[0];

  @override
  void initState() {
    super.initState();
    audioPlayer.setAudioSource(
      ConcatenatingAudioSource(
        children: [
          AudioSource.uri(
            Uri.parse('asset:///${song.url}'),
          ),
        ],
      ),
    );
  }

  @override
  void dispose() {
    audioPlayer.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      extendBodyBehindAppBar: true,

      /// Body Is Appbar
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0.0,
      ),
      body: Stack(
        fit: StackFit.expand,

        /// Image Is All Screen
        children: [
          Image(
            image: AssetImage(
              song.coverUrl,
            ),
            fit: BoxFit.cover,
          ),
          _BackgroundSong(),
          _MusicPlayer(song: song),
        ],
      ),
    );
  }
}

class _BackgroundSong extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        gradient: LinearGradient(
          begin: AlignmentDirectional.topCenter,
          end: AlignmentDirectional.bottomCenter,
          colors: [
            Colors.deepPurple.shade200.withOpacity(
              0.4,
            ),
            Colors.deepPurple.shade200.withOpacity(
              0.7,
            ),
            Colors.deepPurple.shade700.withOpacity(
              1.0,
            ),
            Colors.deepPurple.shade700.withOpacity(
              1.0,
            ),
          ],
        ),
      ),
    );
  }
}

class _MusicPlayer extends StatelessWidget {
  _MusicPlayer({
    Key? key,
    required this.song,
  }) : super(key: key);
  final SongsModel song;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(
        vertical: 40,
        horizontal: 25,
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisAlignment: MainAxisAlignment.end,
        children: [
          Text(
            song.title,
            style: Theme.of(context).textTheme.headlineSmall!.copyWith(
                  color: Colors.white,
                  fontWeight: FontWeight.bold,
                ),
          ),
          const SizedBox(
            height: 10,
          ),
          Text(
            song.title,
            maxLines: 2,
            style: Theme.of(context).textTheme.bodySmall!.copyWith(
                  color: Colors.white,
                ),
          ),
          const SizedBox(
            height: 30,
          ),
          StreamBuilder<SeekBarData>(
            stream: _seekBarDataStream,
            builder: (context, snapshot) {
              final positionData = snapshot.data;
              return SeekBar(
                position: positionData?.position ?? Duration.zero,
                duration: positionData?.duration ?? Duration.zero,
                onChangedEnd:
                    audioPlayer.seek, // if we drag the value of player
              );
            },
          ),
          const SizedBox(
            height: 15,
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              StreamBuilder<SequenceState?>(
                stream: audioPlayer.sequenceStateStream,
                builder: (context, index) {
                  return IconButton(
                    iconSize: 45.0,
                    onPressed: audioPlayer.hasPrevious
                        ? audioPlayer.seekToPrevious
                        : null,
                    icon: const Icon(
                      Icons.skip_previous,
                      color: Colors.white,
                    ),
                  );
                },
              ),
              StreamBuilder(
                stream: audioPlayer.playerStateStream,
                builder: (context, snapshot) {
                  if (snapshot.hasData) {
                    final playerState = snapshot.data;
                    final processingState =
                        (playerState! as PlayerState).processingState;
                    if (processingState == ProcessingState.loading ||
                        processingState == ProcessingState.buffering) {
                      return Container(
                        width: 64,
                        height: 64,
                        margin: const EdgeInsets.all(
                          10.0,
                        ),
                        child: const CircularProgressIndicator(),
                      );
                    } else if (!audioPlayer.playing) {
                      return IconButton(
                        iconSize: 76,
                        onPressed: audioPlayer.play,
                        icon: const Icon(
                          Icons.play_circle,
                          color: Colors.white,
                        ),
                      );
                    } else if (processingState != ProcessingState.completed) {
                      return IconButton(
                        iconSize: 76,
                        onPressed: audioPlayer.pause,
                        icon: const Icon(
                          Icons.pause_circle,
                          color: Colors.white,
                        ),
                      );
                    } else {
                      return IconButton(
                        iconSize: 76,
                        icon: const Icon(
                          Icons.replay_circle_filled_outlined,
                          color: Colors.white,
                        ),
                        onPressed: () => audioPlayer.seek(
                          Duration.zero,
                          index: audioPlayer.effectiveIndices!.first,
                        ),
                      );
                    }
                  } else {
                    return const CircularProgressIndicator();
                  }
                },
              ),
              StreamBuilder<SequenceState?>(
                stream: audioPlayer.sequenceStateStream,
                builder: (context, index) {
                  return IconButton(
                    iconSize: 45.0,
                    onPressed:
                        audioPlayer.hasNext ? audioPlayer.seekToNext : null,
                    icon: const Icon(
                      Icons.skip_next,
                      color: Colors.white,
                    ),
                  );
                },
              ),
            ],
          ),
          const SizedBox(
            height: 15,
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              IconButton(
                iconSize: 35,
                onPressed: () {},
                icon: const Icon(
                  Icons.settings,
                  color: Colors.white,
                ),
              ),
              IconButton(
                iconSize: 35,
                onPressed: () {},
                icon: const Icon(
                  Icons.cloud_download,
                  color: Colors.white,
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
