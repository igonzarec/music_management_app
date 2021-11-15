// Flutter imports:
import 'package:flutter/material.dart';

// Package imports:
import 'package:flutter_bloc/flutter_bloc.dart';

// Project imports:
import 'package:music_management_app/albums/details/application/last_fm_album_star_cubit.dart';
import 'package:music_management_app/albums/local_albums/application/last_fm_local_albums_bloc.dart';
import 'package:music_management_app/albums/local_albums/application/last_fm_local_albums_event.dart';
import 'package:music_management_app/albums/local_albums/presentation/last_fm_local_albums_screen.dart';

class MusicManagementApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {

    return MultiBlocProvider(
      providers: [
        BlocProvider(
          create: (_) => LastFmLocalAlbumsBloc()..add(LocalAlbumsQuery()),
        ),
        BlocProvider(
          create: (context) => LastFmAlbumStarCubit(),
        ),
      ],
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        title: 'Music Management App',
        theme: ThemeData(
          appBarTheme: const AppBarTheme(
            titleTextStyle:
                TextStyle(fontSize: 18, fontFamily: 'MontserratAlternates'),
            backgroundColor: Colors.black87,
          ),
          primarySwatch: Colors.red,
          scaffoldBackgroundColor: Colors.grey[200],
          inputDecorationTheme: InputDecorationTheme(
            border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(28),
              borderSide: const BorderSide(color: Colors.black),
            ),
          ),
          textTheme: Theme.of(context).textTheme.apply(
                fontFamily: 'MontserratAlternates',
              ),
        ),
        home: const LastFmLocalAlbumsScreen(),
      ),
    );
  }
}

//Title for eventual presentation screen
/*
  Text.rich(
          TextSpan(
            children: <TextSpan>[
              const TextSpan(
                  text: 'last.fm',
                  style: TextStyle(fontWeight: FontWeight.w400)),
              TextSpan(
                  text: ' music management app',
                  style: TextStyle(
                      color: Colors.red.shade400, fontWeight: FontWeight.w300)),
            ],
          ),
        )
   */
