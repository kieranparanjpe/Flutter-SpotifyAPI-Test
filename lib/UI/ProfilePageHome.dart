import 'dart:math';

import 'package:flutter/material.dart';
import 'package:text_scroll/text_scroll.dart';
import '../Logic/GlobalVariables.dart';
import 'StatsPageHome.dart';
import '../Logic/SpotifyAPIHandler.dart';

class ProfilePageHome extends StatefulWidget {
  const ProfilePageHome({Key? key}) : super(key: key);

  @override
  State<ProfilePageHome> createState() => _ProfilePageHomeState();
}

class _ProfilePageHomeState extends State<ProfilePageHome> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      extendBody: true,
      backgroundColor: darkGrey,
      body: SafeArea(
          child: Center(
              child: FractionallySizedBox(
                  widthFactor: 0.97,
                  heightFactor: 0.98,
                  child: Container(
                      decoration: BoxDecoration(
                          color: mediumGrey,
                          borderRadius: BorderRadius.circular(40)),
                      child: Padding(
                        padding: const EdgeInsets.only(
                            left: 5, right: 5, top: 10, bottom: 20),
                        child: Column(
                            children: [
                              AppBar(
                                automaticallyImplyLeading: false,
                                toolbarHeight: displaySize.height / 12,
                                centerTitle: true,
                                title: const Align(
                                    alignment: Alignment.centerLeft,
                                    child: Text("Your Profile",
                                        style: TextStyle(
                                            fontSize: 40,
                                            fontWeight: FontWeight.bold))),
                                backgroundColor: darkGrey,
                                elevation: 0,
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(80),
                                ),
                              ),
                              const SizedBox(height: 10),
                              !loggedIn
                                  ? Expanded(
                                      child: Align(
                                        alignment: Alignment.center,
                                        child: Container(
                                          width: 300,
                                          height: 65,
                                          child: ElevatedButton(
                                            onPressed: () {
                                              openAuthPage();
                                            },
                                            style:  ElevatedButton.styleFrom(
                                                backgroundColor: Colors.green,
                                                elevation: 0,
                                                splashFactory:
                                                    NoSplash.splashFactory,
                                                shape: RoundedRectangleBorder(
                                                  borderRadius: BorderRadius.circular(80)
                                                )
                                            ),
                                            child: const Text(
                                              "Login with Spotify",
                                              style: TextStyle(
                                                color: Colors.white,
                                                fontSize: 24,
                                              ),
                                            ),
                                          ),
                                        ),
                                      ),
                                    )
                                  : Column(
                                  mainAxisAlignment:
                                      MainAxisAlignment.start,
                                  children: [
                                    Container(
                                      decoration: BoxDecoration(
                                          color: darkGrey,
                                          borderRadius:
                                              BorderRadius.circular(10)),
                                      child: Padding(
                                        padding: const EdgeInsets.only(left: 10, right: 10, bottom: 10, top: 10),
                                        child: Column(
                                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                          children: [
                                            Align(
                                              alignment: Alignment.centerLeft,
                                              child: Text("Welcome back ${myProfile.displayName}",
                                                  style: const TextStyle(
                                                    color: Colors.white,
                                                    fontSize: 24,
                                                  ),
                                                  textAlign: TextAlign.right),
                                            ),
                                            const SizedBox(height: 15),
                                            Row(
                                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                              crossAxisAlignment: CrossAxisAlignment.end,
                                              children: [
                                                Expanded(
                                                  flex: 2,
                                                  child: AspectRatio(
                                                    aspectRatio: 1,
                                                    child: Container(
                                                      decoration: BoxDecoration(
                                                          shape: BoxShape.circle,
                                                          image: DecorationImage(
                                                              image: NetworkImage(myProfile.profilePicture),
                                                              fit: BoxFit.fill
                                                          )
                                                      ),
                                                    ),
                                                  ),
                                                ),
                                                Expanded(
                                                  flex: 3,
                                                  child: Align(
                                                    alignment: Alignment.bottomRight,
                                                    child: Text("${myProfile.followers} followers",
                                                        style: const TextStyle(
                                                          color: Colors.white,
                                                          fontSize: 24,
                                                        ),
                                                        textAlign: TextAlign.right),
                                                  ),
                                                )
                                              ],
                                            )
                                          ],
                                        ),
                                      ),
                                    ),
                                    const SizedBox(height: 10),
                                    Container(
                                      decoration: BoxDecoration(
                                          color: darkGrey,
                                          borderRadius:
                                          BorderRadius.circular(10)),
                                      child: Padding(
                                        padding: const EdgeInsets.only(left: 10, right: 10, bottom: 10, top: 10),
                                        child: Column(
                                          mainAxisAlignment: MainAxisAlignment.start,
                                          children: [
                                            const Align(
                                              alignment: Alignment.centerLeft,
                                              child: Text("Now Playing: ",
                                                  style: TextStyle(
                                                    color: Colors.white,
                                                    fontSize: 24,
                                                  ),
                                                  textAlign: TextAlign.left),
                                            ),
                                            const SizedBox(height: 15),

                                            Row(
                                              mainAxisAlignment: MainAxisAlignment.center,
                                              crossAxisAlignment: CrossAxisAlignment.start,
                                              children: [
                                                Expanded(
                                                  flex: 2,
                                                  child: AspectRatio(
                                                    aspectRatio: 1,
                                                    child: Container(
                                                      decoration: BoxDecoration(
                                                          image: DecorationImage(
                                                              image: NetworkImage(myProfile.myCurrentTrack.albumCover),
                                                              fit: BoxFit.fill
                                                          )
                                                      ),
                                                    ),
                                                  ),
                                                ),
                                                const SizedBox(width: 10),
                                                Expanded(
                                                  flex: 3,
                                                  child: Column(
                                                    children: [
                                                      Align(
                                                        alignment: Alignment.centerLeft,
                                                        child: TextScroll(myProfile.myCurrentTrack.title,
                                                            selectable: true,
                                                            delayBefore: const Duration(milliseconds: 1000),
                                                            pauseBetween: const Duration(milliseconds: 1000),
                                                            velocity: const Velocity(pixelsPerSecond: Offset(50, 0)),
                                                            style: const TextStyle(
                                                              color: Colors.white,
                                                              fontSize: 24,
                                                              fontWeight: FontWeight.bold
                                                            ),
                                                            textAlign: TextAlign.left),
                                                      ),
                                                      const SizedBox(height: 5),
                                                      Align(
                                                        alignment: Alignment.centerLeft,
                                                        child: TextScroll("on ${myProfile.myCurrentTrack.album}",
                                                            selectable: true,
                                                            delayBefore: const Duration(milliseconds: 1000),
                                                            pauseBetween: const Duration(milliseconds: 1000),
                                                            velocity: const Velocity(pixelsPerSecond: Offset(50, 0)),
                                                            style: const TextStyle(
                                                                color: Colors.white,
                                                                fontSize: 18,
                                                            ),
                                                            textAlign: TextAlign.left),
                                                      ),
                                                      const SizedBox(height: 5),
                                                      Align(
                                                        alignment: Alignment.centerLeft,
                                                        child: TextScroll("by ${myProfile.myCurrentTrack.artistToString()}",
                                                            selectable: true,
                                                            delayBefore: const Duration(milliseconds: 1000),
                                                            pauseBetween: const Duration(milliseconds: 1000),
                                                            velocity: const Velocity(pixelsPerSecond: Offset(50, 0)),
                                                            style: const TextStyle(
                                                                color: Colors.white,
                                                                fontSize: 18,
                                                            ),
                                                            textAlign: TextAlign.left),
                                                      ),
                                                    ],
                                                  )
                                                )
                                              ],
                                            )
                                          ],
                                        ),
                                      ),
                                    )
                                  ],
                                    )
                            ]),
                      ))))),
      bottomNavigationBar: const NavBar(),
    );
  }
}
