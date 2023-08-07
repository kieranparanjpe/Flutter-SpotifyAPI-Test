import 'dart:io';
import 'package:flutter/material.dart';
import 'package:first_flutter_app/Logic/Templates.dart';
import 'package:http/http.dart' as http;
import 'dart:math';
import 'dart:core';
import 'dart:convert';
import 'package:crypto/crypto.dart';
import 'package:url_launcher/url_launcher.dart';
import 'GlobalVariables.dart';
import 'Templates.dart';

const String clientID = "11350c577ada4e1a956e4acf008e932a";
const String redirectURI = "http://localhost:3000";
String codeVerifier = "";
bool loggedIn = true;

Token accessToken = Token.blank();

Profile myProfile = Profile(displayName: "display_name", profilePicture: "data:image/jpeg;base64,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", followers: 69);

Future<void> loginFromAuthenticator() async {
  Uri current = Uri.base;
  var code = current.queryParameters["code"];
  if (code == null) {
    loggedIn = false;
  } else {
    loggedIn = true;
    accessToken = await getAccessToken(code);
    myProfile = await fetchProfile(accessToken.token);
    populateCurrentlyListening(accessToken.token);
    print("profile name ${myProfile.displayName}");
    print("profile pic ${myProfile.profilePicture}");
  }
}

Future<Token> getAccessToken(String code) async {
  String? verifier = await loadData("verifier");

  var url = Uri.parse('https://accounts.spotify.com/api/token');
  var params = {
    "client_id": clientID,
    "grant_type": "authorization_code",
    "code": code,
    "redirect_uri": "http://localhost:3000",
    "code_verifier": verifier.toString(),
  };
  var headers = {'Content-Type': 'application/x-www-form-urlencoded'};

  final response = await http.post(url, headers: headers, body: bodyToQuery(params));

  if (response.statusCode == HttpStatus.ok) {
    return Token.fromJson(json.decode(response.body));
  } else {
    print("Error code: ${response.statusCode}");
    print("Error details: ${response.body}");
  }



  return Token(token: "", refreshToken: "", expiresIn: 0);
}

String bodyToQuery(Map<String, dynamic> body) {
  return body.entries
      .map((entry) => '${Uri.encodeComponent(entry.key)}=${Uri.encodeComponent(entry.value.toString())}')
      .join('&');
}

String generateCodeVerifier(int length) {
  String text = '';
  String possible =
      'ABCDEFGHIJKLMNOPQRSTUVWXYZabcdefghijklmnopqrstuvwxyz0123456789';

  for (int i = 0; i < length; i++) {
    int index = Random().nextInt(possible.length);
    text += possible.substring(index, index + 1);
  }
  return text;
}

String generateCodeChallenge(String codeVerifier) {
  var data = utf8.encode(codeVerifier);
  Digest digest = sha256.convert(data);
  String encode = base64.encode(digest.bytes);
  encode = encode.replaceAll("+", '-').replaceAll("/", "_");
  encode = encode.replaceAll(RegExp('=+\$'), '');
  return encode;

}

Future<void> openAuthPage() async {
  var verifier = generateCodeVerifier(128);
  var challenge = generateCodeChallenge(verifier);
  await saveData("verifier", verifier);

  print("verifier $verifier");
  print("challenge $challenge");

  String params = "";
  params += "client_id=$clientID";
  params += "&response_type=code";
  params += "&redirect_uri=$redirectURI";
  params += "&scope=user-read-private"
      "%20user-read-email"
      "%20user-read-playback-state"
      "%20user-read-currently-playing"
      "%20user-top-read";
  params += "&code_challenge_method=S256";
  params += "&code_challenge=$challenge";

  Uri url = Uri.parse("https://accounts.spotify.com/authorize?$params");

  launchInBrowser(url);
}

Future<void> launchInBrowser(Uri url) async {
  if (!await launchUrl(
    url,
    mode: LaunchMode.externalApplication,
  )) {
    throw Exception('Could not launch $url');
  }
}

Future<Profile> fetchProfile(String token) async {
  var result = await http.get(Uri.parse("https://api.spotify.com/v1/me"),
      headers: <String, String>{ "Authorization": "`Bearer $token`" }
  );

  return Profile.fromJson(json.decode(result.body));
}

void populateCurrentlyListening(String token) async
{
  var result = await http.get(Uri.parse("https://api.spotify.com/v1/me/player"),
      headers: <String, String>{ "Authorization": "`Bearer $token`" }
  );

  print(result.body);

  if(result.statusCode == 200)
  {
    myProfile.myCurrentTrack = Track.fromJson(json.decode(result.body));
    if(myProfile.myCurrentTrack?.title == "") {
     // myProfile.myCurrentTrack = null;
    }
  }
}

void getTopTracks(TimeSpan span) async {
  var result = await http.get(Uri.parse("https://api.spotify.com/v1/me/top/tracks?time_range=${span.name}&limit=50"),
      headers: <String, String>{ "Authorization": "`Bearer ${accessToken.token}" }
  );

  print(result.body);

  if(result.statusCode == 200)
  {
    myProfile.myTopItems.populateTrack(result.body, span);
    if(myProfile.myCurrentTrack?.title == "") {
      // myProfile.myCurrentTrack = null;
    }
  }
}
