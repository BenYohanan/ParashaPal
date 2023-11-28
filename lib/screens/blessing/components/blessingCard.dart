import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:pocket_siddur/app_properties.dart';

import '../../../models/blessings.dart';
import '../../../size_config.dart';

class BlessingCard extends StatefulWidget {
  const BlessingCard({
    Key? key,
    required this.audioBlessing,
  }) : super(key: key);

  final Blessing audioBlessing;

  @override
  State<BlessingCard> createState() => _BlessingCardState();
}

class _BlessingCardState extends State<BlessingCard> {
  bool isPlaying = false;

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        SizedBox(
          width: getProportionateScreenWidth(80),
          child: GestureDetector(
            onTap: () {
              //_playAudio(widget.audioBlessing.audioFilePath);
            },
            child: AspectRatio(
              aspectRatio: 0.88,
              child: Container(
                padding: EdgeInsets.all(
                  getProportionateScreenWidth(16),
                ),
                decoration: BoxDecoration(
                  color: const Color(0xFFF5F6F9),
                  borderRadius: BorderRadius.circular(15),
                ),
                child: Align(
                  alignment: Alignment.centerLeft,
                  child: SvgPicture.asset(
                    "assets/icons/audio.svg",
                    height: getProportionateScreenWidth(18),
                    color: darkGrey,
                  ),
                ),
              ),
            ),
          ),
        ),
        SizedBox(
          width: getProportionateScreenWidth(10),
        ),
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            timer(
              "Time In:",
              "attendanceViewModel.checkIn!",
            ),
            timer(
              "Time Out:",
              "attendanceViewModel.checkOut!",
            ),
            timer(
              "Time Spent:",
              "${""}(hrs)",
            )
          ],
        )
      ],
    );
  }

  // Future<void> _playAudio(String audioPath) async {
  //   try {
  //     await _audioPlayer.setAudioSource(AudioSource.asset(audioPath));
  //     _audioPlayer.play();
  //   } catch (e) {
  //     print("Error playing audio: $e");
  //   }
  // }

  Text timer(String label, String value) {
    return Text.rich(
      TextSpan(
        text: "$label $value",
        style: TextStyle(
          color: darkGrey,
          fontSize: getProportionateScreenWidth(12),
        ),
      ),
    );
  }
}
