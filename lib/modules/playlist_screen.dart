import 'package:flutter/material.dart';
import 'package:music_application/models/playlist_model.dart';

class PlaylistScreen extends StatefulWidget {
  PlaylistScreen({Key? key}) : super(key: key);

  @override
  State<PlaylistScreen> createState() => _PlaylistScreenState();
}

class _PlaylistScreenState extends State<PlaylistScreen> {
  PlayListModel playListModel = PlayListModel.playlists[0];
  bool isPlay = false;

  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.of(context).size.width;
    return Container(
      decoration: BoxDecoration(
        gradient: LinearGradient(
          begin: AlignmentDirectional.topCenter,
          end: AlignmentDirectional.bottomCenter,
          colors: [
            Colors.deepPurple.shade800,
            Colors.deepPurple.shade200,
          ],
        ),
      ),
      child: Scaffold(
        backgroundColor: Colors.transparent,
        appBar: AppBar(
          backgroundColor: Colors.transparent,
          elevation: 0.0,
          title: const Text('Playlist'),
          centerTitle: true,
        ),
        body: SingleChildScrollView(
          physics: const BouncingScrollPhysics(),
          child: Padding(
            padding: const EdgeInsets.all(16.0),
            child: Column(
              children: [
                _PlaylistInformation(playListModel),
                const SizedBox(
                  height: 30,
                ),
                _togglePlaylist(isPlay, width),
                const SizedBox(
                  height: 20,
                ),
                ListView.builder(
                  shrinkWrap: true,
                  physics: const NeverScrollableScrollPhysics(),
                  itemBuilder: (context, index) {
                    return ListTile(
                      leading: Text(
                        '${index + 1}',
                        style: Theme.of(context)
                            .textTheme
                            .bodyMedium!
                            .copyWith(fontWeight: FontWeight.bold),
                      ),
                      title: Text(
                        playListModel.songs[index].title,
                        style: Theme.of(context)
                            .textTheme
                            .bodyLarge!
                            .copyWith(fontWeight: FontWeight.bold),
                      ),
                      subtitle: Text('${playListModel.songs[index].description} ⚬ 02:45'),
                      trailing: const Icon(
                        Icons.more_vert,
                        color: Colors.white,
                      ),
                    );
                  },
                  itemCount: playListModel.songs.length,
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

class _PlaylistInformation extends StatelessWidget {
  PlayListModel playListModel;

  _PlaylistInformation(this.playListModel);

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        ClipRRect(
          borderRadius: BorderRadius.circular(
            20.0,
          ),
          child: Image(
            image: NetworkImage(
              playListModel.imageUrl,
            ),
            width: MediaQuery.of(context).size.width * 0.6,
            height: MediaQuery.of(context).size.height * 0.3,
            fit: BoxFit.cover,
          ),
        ),
        const SizedBox(
          height: 30,
        ),
        Text(
          playListModel.title,
          style: Theme.of(context).textTheme.headlineSmall!.copyWith(
                fontWeight: FontWeight.bold,
              ),
        ),
      ],
    );
  }
}

class _togglePlaylist extends StatefulWidget {
  var isPlay;
  var width;

  _togglePlaylist(this.isPlay, this.width);

  @override
  State<_togglePlaylist> createState() => _togglePlaylistState();
}

class _togglePlaylistState extends State<_togglePlaylist> {
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        setState(() {
          widget.isPlay = !widget.isPlay;
        });
      },
      child: Container(
        height: 50,
        width: widget.width,
        decoration: BoxDecoration(
          color: widget.isPlay ? Colors.white : Colors.deepPurple.shade400,
          borderRadius: BorderRadius.circular(
            15.0,
          ),
        ),
        child: Stack(
          children: [
            AnimatedPositioned(
              duration: const Duration(
                milliseconds: 1000,
              ),
              left: widget.isPlay ? 0 : widget.width * 0.45,
              child: Container(
                height: 50,
                width: widget.width * .45,
                decoration: BoxDecoration(
                  color: widget.isPlay ? Colors.deepPurple.shade400 : Colors.white,
                  borderRadius: BorderRadius.circular(
                    15.0,
                  ),
                ),
              ),
            ),
            Row(
              children: [
                Expanded(
                  child: Row(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Center(
                        child: Text(
                          'Play',
                          style: TextStyle(
                            color: widget.isPlay
                                ? Colors.deepPurple
                                : Colors.white,
                            fontSize: 17,
                          ),
                        ),
                      ),
                      const SizedBox(
                        width: 5,
                      ),
                      Icon(
                        Icons.play_circle,
                        color: widget.isPlay ? Colors.deepPurple : Colors.white,
                      ),
                    ],
                  ),
                ),
                Expanded(
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Center(
                        child: Text(
                          'Shuffle',
                          style: TextStyle(
                            color: widget.isPlay
                                ? Colors.white
                                : Colors.deepPurple,
                            fontSize: 17,
                          ),
                        ),
                      ),
                      const SizedBox(
                        width: 5,
                      ),
                      Icon(
                        Icons.shuffle,
                        color: widget.isPlay ? Colors.white : Colors.deepPurple,
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
