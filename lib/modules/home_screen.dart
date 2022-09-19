import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:music_application/models/playlist_model.dart';
import 'package:music_application/modules/playlist_screen.dart';
import 'package:music_application/shared/components/components.dart';
import 'package:music_application/widgets/playlist_card.dart';
import 'package:music_application/widgets/widgets.dart';
import '../models/songs_model.dart';
import '../widgets/sections_headers.dart';

List<SongsModel> newSongs = SongsModel.songs;
List<PlayListModel> newPlaylist = PlayListModel.playlists;

class MusicHome extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
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

        /// Setup To background color of scaffold and appbar
        appBar: _CustomAppBar(),
        bottomNavigationBar: _CustomNavigatorBar(),
        body: SingleChildScrollView(
          physics: const BouncingScrollPhysics(),
          child: Column(
            children: [
              _DiscoverMusic(),
              _TrendingMusic(),
              _PlaylistsMusic(),
            ],
          ),
        ),
      ),
    );
  }
}

class _CustomAppBar extends StatelessWidget with PreferredSizeWidget {
  @override
  Widget build(BuildContext context) {
    return AppBar(
      elevation: 0,
      backgroundColor: Colors.transparent,
      leading: const Icon(
        Icons.grid_view_rounded,
      ),
      actions: [
        Container(
          margin: const EdgeInsets.only(
            right: 15.0,
          ),
          child: const CircleAvatar(
            backgroundImage: NetworkImage(
              'https://media.istockphoto.com/photos/mug-of-coffee-on-table-picture-id1277074078?b=1&k=20&m=1277074078&s=170667a&w=0&h=qNvFcGFSHg_l4r85w9lQvx6iiFpOtKABEuvwB4Gxju4=',
            ),
          ),
        ),
      ],
    );
  }

  @override
  Size get preferredSize => const Size.fromHeight(56.0);
}

class _CustomNavigatorBar extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return BottomNavigationBar(
      backgroundColor: Colors.deepPurple.shade800,
      type: BottomNavigationBarType.fixed,
      showSelectedLabels: false,
      showUnselectedLabels: false,
      selectedItemColor: Colors.white,
      unselectedItemColor: Colors.white,
      items: const [
        BottomNavigationBarItem(
          icon: Icon(
            Icons.home_outlined,
          ),
          label: 'Home',
        ),
        BottomNavigationBarItem(
          icon: Icon(
            Icons.favorite_outline,
          ),
          label: 'Favorites',
        ),
        BottomNavigationBarItem(
          icon: Icon(
            Icons.play_circle_outline,
          ),
          label: 'Play',
        ),
        BottomNavigationBarItem(
          icon: Icon(
            Icons.people_outline,
          ),
          label: 'Profile',
        ),
      ],
    );
  }
}

class _DiscoverMusic extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(20.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'Welcome',
            style: Theme.of(context).textTheme.bodyLarge!.copyWith(),
          ),
          const SizedBox(
            height: 7.5,
          ),
          Text(
            'Enjoy Your Favorites Music',
            style: Theme.of(context).textTheme.headline6!.copyWith(
                  fontWeight: FontWeight.bold,
                ),
          ),
          const SizedBox(
            height: 20,
          ),
          TextFormField(
            decoration: InputDecoration(
              hintText: 'Search',
              filled: true,

              /// To Can FillColor
              fillColor: Colors.white,

              isDense: true,

              /// To remove Padding
              hintStyle: Theme.of(context).textTheme.bodyMedium!.copyWith(
                    color: Colors.grey.shade400,
                  ),
              prefixIcon: Icon(
                Icons.search,
                color: Colors.grey.shade400,
              ),
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(
                  15.0,
                ),
                borderSide: BorderSide.none,
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class _TrendingMusic extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(
        top: 20,
        left: 20,
        bottom: 20,
      ),
      child: Column(
        children: [
          const Padding(
            padding: EdgeInsets.only(
              right: 20.0,
            ),
            child: SectionsHeader(
              title: 'Trending Music',
            ),
          ),
          const SizedBox(
            height: 20.0,
          ),
          SizedBox(
            height: MediaQuery.of(context).size.height * 0.27,
            child: ListView.builder(
              physics: const BouncingScrollPhysics(),
              scrollDirection: Axis.horizontal,
              itemBuilder: (context, index) {
                return SongCard(newSongs: newSongs[index]);
              },
              itemCount: newSongs.length,
            ),
          ),
        ],
      ),
    );
  }
}

class _PlaylistsMusic extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(20.0),
      child: Column(
        children: [
          const SectionsHeader(
            title: 'Playlists',
          ),
          const SizedBox(
            height: 15,
          ),
          ListView.builder(
            shrinkWrap: true,
            physics: const NeverScrollableScrollPhysics(),
            itemBuilder: (context, index) => PlaylistCard(
              newPlaylist: newPlaylist[index],
            ),
            itemCount: newPlaylist.length,
          ),
        ],
      ),
    );
  }
}
