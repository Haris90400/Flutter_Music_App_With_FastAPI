import 'dart:io';

import 'package:client/core/constants/server_constant.dart';
import 'package:client/core/failure/failure.dart';
import 'package:fpdart/fpdart.dart';
import 'package:http/http.dart' as http;
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'home_repository.g.dart';

@riverpod
HomeRepository homeRepository(HomeRepositoryRef ref) {
  return HomeRepository();
}

class HomeRepository {
  Future<Either<AppFailure, String>> uploadSong({
    required File selectedAudio,
    required File selectedImage,
    required String songName,
    required String artist,
    required String hexcode,
    required String token,
  }) async {
    try {
      final request = http.MultipartRequest(
        'POST',
        Uri.parse('${ServerConstant.serverUrl}/songs/upload'),
      );

      request
        ..files.addAll(
          [
            await http.MultipartFile.fromPath(
              'song',
              selectedAudio.path,
            ),
            await http.MultipartFile.fromPath(
              'thumbnail',
              selectedImage.path,
            )
          ],
        )
        ..fields.addAll(
            {"artist": artist, "song_name": songName, "hex_code": hexcode})
        ..headers.addAll({
          'x-auth-token': token,
        });

      final res = await request.send();

      if (res.statusCode != 201) {
        return Left(
          AppFailure(
            await res.stream.bytesToString(),
          ),
        );
      }

      return Right(await res.stream.bytesToString());
    } catch (e) {
      return Left(
        AppFailure(
          e.toString(),
        ),
      );
    }
  }
}
