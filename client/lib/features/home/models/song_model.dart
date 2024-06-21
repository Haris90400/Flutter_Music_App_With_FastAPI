import 'dart:convert';

// ignore_for_file: non_constant_identifier_names

class SongModel {
  final String song_name;
  final String id;
  final String hex_code;
  final String artist;
  final String song_url;
  final String thumbnail_url;
  SongModel({
    required this.song_name,
    required this.id,
    required this.hex_code,
    required this.artist,
    required this.song_url,
    required this.thumbnail_url,
  });

  SongModel copyWith({
    String? song_name,
    String? id,
    String? hex_code,
    String? artist,
    String? song_url,
    String? thumbnail_url,
  }) {
    return SongModel(
      song_name: song_name ?? this.song_name,
      id: id ?? this.id,
      hex_code: hex_code ?? this.hex_code,
      artist: artist ?? this.artist,
      song_url: song_url ?? this.song_url,
      thumbnail_url: thumbnail_url ?? this.thumbnail_url,
    );
  }

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'song_name': song_name,
      'id': id,
      'hex_code': hex_code,
      'artist': artist,
      'song_url': song_url,
      'thumbnail_url': thumbnail_url,
    };
  }

  factory SongModel.fromMap(Map<String, dynamic> map) {
    return SongModel(
      song_name: map['song_name'] ?? '',
      id: map['id'] ?? '',
      hex_code: map['hex_code'] ?? '',
      artist: map['artist'] ?? '',
      song_url: map['song_url'] ?? '',
      thumbnail_url: map['thumbnail_url'] ?? '',
    );
  }

  String toJson() => json.encode(toMap());

  factory SongModel.fromJson(String source) =>
      SongModel.fromMap(json.decode(source) as Map<String, dynamic>);

  @override
  String toString() {
    return 'SongModel(song_name: $song_name, id: $id, hex_code: $hex_code, artist: $artist, song_url: $song_url, thumbnail_url: $thumbnail_url)';
  }

  @override
  bool operator ==(covariant SongModel other) {
    if (identical(this, other)) return true;

    return other.song_name == song_name &&
        other.id == id &&
        other.hex_code == hex_code &&
        other.artist == artist &&
        other.song_url == song_url &&
        other.thumbnail_url == thumbnail_url;
  }

  @override
  int get hashCode {
    return song_name.hashCode ^
        id.hashCode ^
        hex_code.hashCode ^
        artist.hashCode ^
        song_url.hashCode ^
        thumbnail_url.hashCode;
  }
}
