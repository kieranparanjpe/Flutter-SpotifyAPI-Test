import 'dart:convert';

class Token
{
  late String token;
  late String refreshToken;
  late int expiresIn;

  Token({required this.token, required this.refreshToken, required this.expiresIn});

  factory Token.fromJson(Map<String, dynamic> json) {
    return Token(
      token: json['access_token'],
      refreshToken: json['refresh_token'],
      expiresIn: json['expires_in'],
    );
  }

  Token.blank();
}

class Profile
{
  late String displayName;
  late String profilePicture;
  late int followers;

  Track myCurrentTrack = Track.blank();

  TopItems myTopItems = TopItems();

  Profile({required this.displayName, required this.profilePicture, required this.followers})
  {
    myCurrentTrack.albumCover = profilePicture;
  }

  factory Profile.fromJson(Map<String, dynamic> json) {
    return Profile(
      displayName: json['display_name'],
      profilePicture: json['images'][1]["url"],
      followers: json['followers']['total'],
    );
  }
}

enum TimeSpan
{
  short_term,
  medium_term,
  long_term
}

class TopItems
{
  List<Artist> topArtistMonth = [];
  List<Artist> topArtistYear = [];
  List<Artist> topArtistAllTime = [];

  List<Track> topTrackMonth = [];
  List<Track> topTrackYear = [];
  List<Track> topTrackAllTime = [];

  void populateArtist(String _json, TimeSpan span)
  {
    List<dynamic> artists = json.decode(_json)['items'];

    for(var artist in artists)
    {
      switch(span)
      {
        case(TimeSpan.short_term):
            topArtistMonth.add(Artist.fromJson(artist));
            break;
        case(TimeSpan.medium_term):
            topArtistYear.add(Artist.fromJson(artist));
            break;
        case(TimeSpan.long_term):
            topArtistAllTime.add(Artist.fromJson(artist));
      }
    }
  }

  void populateTrack(String _json, TimeSpan span)
  {
    List<dynamic> tracks = json.decode(_json)['items'];

    for(var track in tracks)
    {
      switch(span)
      {
        case(TimeSpan.short_term):
          topTrackMonth.add(Track.fromList(track));
          break;
        case(TimeSpan.medium_term):
          topTrackYear.add(Track.fromList(track));
          break;
        case(TimeSpan.long_term):
          topTrackAllTime.add(Track.fromList(track));
      }
    }

    print(topTrackMonth);
  }
}

class Artist
{
  String name = "";
  String image = "";

  Artist.blank();

  Artist(this.name, this.image);

  factory Artist.fromJson(dynamic _json)
  {
    return Artist(_json['name'], _json['images'][0]);
  }
}

class Track
{
  String albumCover = "";
  String title = "";
  List<String> artists = [];
  String album = "";

  Track.blank();

  Track(this.albumCover, this.title,this.artists, this.album);

  Track.fromJson(Map<String, dynamic> _json)
  {
      albumCover = _json['item']['album']['images'][1]["url"];
      album = _json['item']['album']['name'];
      artists = getArtists(_json['item']['artists']);
      title = _json['item']['name'];
  }

  Track.fromList(dynamic _json)
  {
    albumCover = _json['album']['images'][0]["url"];
    album = _json['album']['name'];
    artists = getArtists(_json['artists']);
    title = _json['name'];
  }

  List<String> getArtists(List<dynamic> _json)
  {
    List<String> r = ["artist not found"];
    if(_json.isNotEmpty) {
      r = [];
    }
    for(var artist in _json)
    {
      r.add(artist["name"]);
    }
    return r;
  }

  String artistToString()
  {
    return artists.toString().substring(1, artists.toString().length - 1);
  }

  @override
  String toString()
  {
    return title;
  }
}