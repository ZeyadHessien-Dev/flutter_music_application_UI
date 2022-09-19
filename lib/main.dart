import 'package:bloc/bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:music_application/modules/home_screen.dart';
import 'package:music_application/modules/playlist_screen.dart';
import 'package:music_application/modules/song_screen.dart';
import 'package:music_application/shared/bloc_observer.dart';
import 'package:music_application/shared/network/local/cache_helper.dart';
import 'package:music_application/shared/network/remote/dio_helper.dart';
import 'package:get/get.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  SystemChrome.setSystemUIOverlayStyle(const SystemUiOverlayStyle(
    statusBarColor: Colors.transparent,
  ));
  Bloc.observer = MyBlocObserver();
  DioHelper.init();
  await CacheHelper.init();
  runApp(MyApp());
}


class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      theme: ThemeData(
        textTheme: Theme.of(context).textTheme.apply(
          bodyColor: Colors.white,
          displayColor: Colors.white,
        ),
      ),
      getPages: [
        GetPage(name: '/', page: () =>  MusicHome()),
        GetPage(name: '/song', page: () =>  SongScreen()),
        GetPage(name: '/playlist', page: () =>  PlaylistScreen()),
      ],
      debugShowCheckedModeBanner: false,
      home: MusicHome(),

    );
  }
}
