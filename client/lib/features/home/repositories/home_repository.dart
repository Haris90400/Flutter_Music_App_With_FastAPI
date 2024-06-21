import 'dart:io';

import 'package:client/core/constants/server_constant.dart';
import 'package:http/http.dart' as http;

class HomeRepository {
  Future<void> uploadSong(File selectedImage, File selectedAudio) async {
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
      ..fields.addAll({
        "artist": "Atif Aslam",
        "song_name": "Tajdare Haram",
        "hex_code": 'FFFFFF'
      })
      ..headers.addAll({
        'x-auth-token':
            "eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJpZCI6IjQ0MmU5OGI5LWIxMTctNDE2YS04N2I1LTE5NmVkOTgxY2YzNSJ9.IawYQTjTxzvZJkcpkRG4fxjglPHhQVNGY0_ELZ4A38A",
      });

    final res = await request.send();
    print(res);
  }
}
