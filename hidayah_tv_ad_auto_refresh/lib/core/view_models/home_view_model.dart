import 'dart:async';

import 'package:cached_network_image/cached_network_image.dart';
import 'package:cached_video_player/cached_video_player.dart';
import 'package:flutter/material.dart';
import 'package:hidayah_tv_ad/core/enums/view_state.dart';
import 'package:hidayah_tv_ad/core/models/ad_model.dart';
import 'package:hidayah_tv_ad/core/services/ad_api.dart';
import 'package:hidayah_tv_ad/core/view_models/base_view_model.dart';
import 'package:hidayah_tv_ad/locator.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:youtube_player_flutter/youtube_player_flutter.dart';

class HomeViewModel extends BaseViewModel {
  final AdAPI _adAPI = locator<AdAPI>();

  CachedVideoPlayerController? videoPlayerController;
  YoutubePlayerController? youtubePlayerController;

  /// ADList
  List<String> aDUrlList = [];

  int currentADIndex = 0;

  int imageDelayInSeconds = 4;

  List<int> imageDuration = [];

  String updatedTime = '';

  Timer? updateADsTimer;

  void initializeAD() {
    final aDUrl = aDUrlList[currentADIndex];

    if (aDUrl.endsWith('.mp4')) {
      videoPlayerController = CachedVideoPlayerController.network(aDUrl)
        ..initialize().then((value) {
          videoPlayerController?.play();
          notifyListeners();
          videoPlayerController?.addListener(videoPlayerListener);
        });
    } else if (aDUrl.endsWith('.jpg') ||
        aDUrl.endsWith('.jpeg') ||
        aDUrl.endsWith('.png')) {
      notifyListeners();

      Future.delayed(Duration(seconds: imageDuration[currentADIndex]), () {
        notifyListeners();

        playNextAD();
      });
    } else {
      final videoId = YoutubePlayer.convertUrlToId(aDUrl);

      youtubePlayerController = YoutubePlayerController(
        initialVideoId: videoId!,
        flags: const YoutubePlayerFlags(
          autoPlay: true,
          mute: false,
          isLive: false,
          loop: true,
        ),
      )..addListener(youtubePlayerListener);
      // youtubePlayerController?.play();
      notifyListeners();
    }
  }

  void videoPlayerListener() {
    if (videoPlayerController!.value.position >=
        videoPlayerController!.value.duration) {
      videoPlayerController?.removeListener(videoPlayerListener);

      playNextAD();
    }
  }

  void youtubePlayerListener() {
    if (youtubePlayerController!.value.playerState == PlayerState.ended) {
      youtubePlayerController?.removeListener(youtubePlayerListener);
      notifyListeners();
      playNextAD();
      notifyListeners();
    }
  }

  void playNextAD() {
    currentADIndex = (currentADIndex + 1) % aDUrlList.length;

    videoPlayerController?.pause();
    videoPlayerController?.removeListener(videoPlayerListener);
    videoPlayerController?.dispose();
    videoPlayerController = null;

    initializeAD();
  }

  Widget _buildVideoPlayer(String videoUrl) {
    return videoPlayerController!.value.isInitialized
        ? AspectRatio(
            aspectRatio: videoPlayerController!.value.aspectRatio,
            child: CachedVideoPlayer(videoPlayerController!),
          )
        : Container(
            height: double.infinity,
            width: double.infinity,
            color: Colors.white,
          );
  }

  Widget _buildYoutubePlayer(String videoUrl) {
    return YoutubePlayer(
      controller: youtubePlayerController!,
    );
  }

  Widget _buildImage(String imageUrl) {
    return CachedNetworkImage(
      imageUrl: imageUrl,
      fit: BoxFit.fill,
      height: double.infinity,
      width: double.infinity,
    );
  }

  Widget buildMediaWidget(String mediaUrl) {
    if (mediaUrl.endsWith('.mp4')) {
      return _buildVideoPlayer(mediaUrl);
    } else if (mediaUrl.endsWith('.jpg') ||
        mediaUrl.endsWith('.jpeg') ||
        mediaUrl.endsWith('.png')) {
      return _buildImage(mediaUrl);
    } else if (mediaUrl.contains('youtube.com') ||
        mediaUrl.contains('youtu.be')) {
      return _buildYoutubePlayer(mediaUrl);
    } else {
      return Container();
    }
  }

  AdModel? aDs;

  Timer? reTryGetADsTimer;

  Future<void> getADs() async {
    setViewState(ViewState.busy);

    final SharedPreferences preferences = await SharedPreferences.getInstance();

    String domain = preferences.getString('domain')!;

    aDs = (await _adAPI.getAdsAPI()) ?? aDs;

    updatedTime = aDs!.updateAt!;

    print('-------------------');
    print(aDs!.updateAt);
    print(aDs!.data);
    print('-------------------');

    while (aDs?.data == null) {
      print(
          '+++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++');
      reTryGetADsTimer = await Future.delayed(
        const Duration(seconds: 8),
        () async {
          aDs = (await _adAPI.getAdsAPI()) ?? aDs;

          updatedTime = aDs!.updateAt!;

          return null;
        },
      );
    }

    for (int i = 0; i < aDs!.data!.length; i++) {
      if (aDs!.data![i].duration != null) {
        imageDuration.add(int.tryParse(aDs!.data![i].duration.toString())!);
      } else {
        imageDuration.add(0);
      }

      String type = '';

      if (aDs!.data![i].addTypes == AddTypes.banner) {
        type = 'PIC.png';
        aDUrlList.add('${domain}static/${aDs!.data![i].uuid!}_$type');
      } else if (aDs!.data![i].addTypes == AddTypes.video) {
        type = 'VID.mp4';
        aDUrlList.add('${domain}static/${aDs!.data![i].uuid!}_$type');
      } else {
        aDUrlList.add(aDs!.data![i].name!);
      }
    }

    setViewState(ViewState.idle);
  }

  Future<bool> getIsADsUpdated() async {
    String updatedTime = (await _adAPI.getAdsAPI())?.updateAt ?? 'noInternet';

    if (updatedTime == 'noInternet') {
      return false;
    } else {
      if (updatedTime != this.updatedTime) {
        return true;
      } else {
        return false;
      }
    }
  }
}
