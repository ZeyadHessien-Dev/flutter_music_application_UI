import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:music_application/models/playlist_model.dart';
class PlaylistCard extends StatelessWidget {
  const PlaylistCard({
    Key? key,
    required this.newPlaylist,
  }) : super(key: key);

  final PlayListModel newPlaylist;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(
        vertical: 10.0,
      ),
      child: InkWell(
        onTap: () {
        Get.toNamed('/playlist');
        },
        child: Container(
          height: 80,
          padding: const EdgeInsets.symmetric(
            vertical: 10.0,
          ),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(
              15.0,
            ),
            color: Colors.deepPurple.shade800.withOpacity(
              .7,
            ),
          ),
          child: Row(
            children: [
              const SizedBox(
                width: 20,
              ),
              // ClipRRect(
              //   borderRadius: BorderRadius.circular(
              //     15.0,
              //   ),
              //   child: Image.network(
              //     newPlaylist.imageUrl,
              //     width: 50,
              //     height: 50,
              //     fit: BoxFit.cover,
              //   ),
              // ),
              ClipRRect(
                borderRadius: BorderRadius.circular(
                  15.0,
                ),
                child: Image(
                  image: NetworkImage(
                    newPlaylist.imageUrl,
                  ),
                  width: 50,
                  height: 50,
                  fit: BoxFit.cover,
                ),
              ),
              const SizedBox(
                width: 20,
              ),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      newPlaylist.title,
                      style: Theme.of(context).textTheme.bodyMedium!.copyWith(
                            fontWeight: FontWeight.bold,
                          ),
                    ),
                    const SizedBox(
                      height: 5,
                    ),
                    Text(
                      '${newPlaylist.songs.length} Songs',
                    ),
                  ],
                ),
              ),
              const Icon(
                Icons.play_circle,
                color: Colors.white,
              ),
              const SizedBox(
                width: 20,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
