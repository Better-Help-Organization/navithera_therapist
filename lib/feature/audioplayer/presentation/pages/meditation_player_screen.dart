import 'package:flutter/material.dart';
import 'package:audioplayers/audioplayers.dart';
import 'meditation_list_screen.dart';

class MeditationPlayerScreen extends StatefulWidget {
  final MeditationItem meditation;

  const MeditationPlayerScreen({Key? key, required this.meditation})
    : super(key: key);

  @override
  State<MeditationPlayerScreen> createState() => _MeditationPlayerScreenState();
}

class _MeditationPlayerScreenState extends State<MeditationPlayerScreen> {
  late final AudioPlayer audioPlayer;
  bool isPlaying = false;
  Duration duration = Duration.zero;
  Duration position = Duration.zero;

  @override
  void initState() {
    super.initState();
    audioPlayer = AudioPlayer();

    // Recommended context/settings (esp. if mixing with other audio):
    audioPlayer.setReleaseMode(
      ReleaseMode.stop,
    ); // stop at end, trigger onPlayerComplete
    // audioPlayer.setPlayerMode(PlayerMode.mediaPlayer); // optional; good for longer files

    // Listen for duration once audio is loaded/played.
    audioPlayer.onDurationChanged.listen((d) {
      setState(() => duration = d);
    });

    // Listen for position updates.
    audioPlayer.onPositionChanged.listen((p) {
      setState(() => position = p);
    });

    // Handle completion.
    audioPlayer.onPlayerComplete.listen((event) {
      setState(() {
        isPlaying = false;
        position = Duration.zero;
      });
    });
  }

  @override
  void dispose() {
    audioPlayer.dispose();
    super.dispose();
  }

  Future<void> playPause() async {
    if (isPlaying) {
      try {
        await audioPlayer.pause();
        setState(() => isPlaying = false);
      } catch (e) {
        debugPrint('Pause error: $e');
      }
    } else {
      try {
        // Important: meditation.audioPath must match pubspec asset key!
        await audioPlayer.play(AssetSource(widget.meditation.audioPath));
        setState(() => isPlaying = true);
      } catch (e) {
        debugPrint('Play error: $e');
        // If you preloaded and still fails, check asset path & pubspec.
      }
    }
  }

  Future<void> seekBackward() async {
    final newPosition = position - const Duration(seconds: 10);
    await audioPlayer.seek(
      newPosition < Duration.zero ? Duration.zero : newPosition,
    );
  }

  Future<void> seekForward() async {
    final newPosition = position + const Duration(seconds: 10);
    await audioPlayer.seek(newPosition > duration ? duration : newPosition);
  }

  String formatDuration(Duration d) {
    String twoDigits(int n) => n.toString().padLeft(2, '0');
    final minutes = twoDigits(d.inMinutes.remainder(60));
    final seconds = twoDigits(d.inSeconds.remainder(60));
    return '$minutes:$seconds';
  }

  @override
  Widget build(BuildContext context) {
    //print(meditation");
    // Slider safety: avoid value > max or NaN when not yet loaded.
    final maxSeconds =
        duration.inSeconds > 0 ? duration.inSeconds.toDouble() : 1.0;
    final valueSeconds =
        position.inSeconds.clamp(0, maxSeconds.toInt()).toDouble();

    return Scaffold(
      backgroundColor: const Color(0xFF1a1a2e),
      appBar: AppBar(
        backgroundColor: const Color(0xFF1a1a2e),
        elevation: 0,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back, color: Colors.white),
          onPressed: () => Navigator.pop(context),
        ),
        title: const Text(
          'Guided Meditation',
          style: TextStyle(
            color: Colors.white,
            fontSize: 18,
            fontWeight: FontWeight.w600,
          ),
        ),
        centerTitle: true,
      ),
      body: Padding(
        padding: const EdgeInsets.all(24.0),
        child: Column(
          children: [
            const SizedBox(height: 40),
            // Album Art (still gradient effect from your code)
            Container(
              width: double.infinity,
              height: 300,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(20),
                image: DecorationImage(
                  image: AssetImage(
                    widget.meditation.imagePath,
                  ), // Replace with your image path
                  fit: BoxFit.cover,
                ),
              ),
            ),
            // Container(
            //   width: double.infinity,
            //   height: 300,
            //   decoration: BoxDecoration(
            //     borderRadius: BorderRadius.circular(20),
            //     gradient: LinearGradient(
            //       begin: Alignment.topLeft,
            //       end: Alignment.bottomRight,
            //       colors: [
            //         widget.meditation.gradientStart,
            //         widget.meditation.gradientEnd,
            //       ],
            //     ),
            //   ),
            //   child: Stack(
            //     children: [
            //       // Rain effect overlay
            //       ...List.generate(50, (index) {
            //         return Positioned(
            //           left: (index * 15.0) % 300,
            //           top: (index * 23.0) % 250,
            //           child: Container(
            //             width: 1,
            //             height: 15,
            //             decoration: BoxDecoration(
            //               color: Colors.white.withOpacity(0.3),
            //               borderRadius: BorderRadius.circular(1),
            //             ),
            //           ),
            //         );
            //       }),
            //     ],
            //   ),
            // ),
            const SizedBox(height: 40),
            // Title
            Text(
              widget.meditation.title.replaceAll('\n', ' '),
              style: const TextStyle(
                color: Colors.white,
                fontSize: 20,
                fontWeight: FontWeight.bold,
              ),
              textAlign: TextAlign.center,
            ),
            const SizedBox(height: 8),
            Text(
              widget.meditation.subtitle,
              style: const TextStyle(
                color: Colors.white70,
                fontSize: 16,
                fontWeight: FontWeight.w400,
              ),
            ),
            const SizedBox(height: 30),

            // Progress Bar
            Column(
              children: [
                SliderTheme(
                  data: SliderTheme.of(context).copyWith(
                    activeTrackColor: const Color(0xFF4ECDC4),
                    inactiveTrackColor: Colors.white24,
                    thumbColor: const Color(0xFF4ECDC4),
                    overlayColor: const Color(0xFF4ECDC4).withOpacity(0.2),
                    thumbShape: const RoundSliderThumbShape(
                      enabledThumbRadius: 8,
                    ),
                    trackHeight: 4,
                  ),
                  child: Slider(
                    min: 0,
                    max: maxSeconds,
                    value: valueSeconds,
                    onChanged: (v) async {
                      if (duration == Duration.zero) return;
                      await audioPlayer.seek(Duration(seconds: v.toInt()));
                    },
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 20),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        formatDuration(position),
                        style: const TextStyle(
                          color: Colors.white70,
                          fontSize: 14,
                        ),
                      ),
                      Text(
                        formatDuration(duration),
                        style: const TextStyle(
                          color: Colors.white70,
                          fontSize: 14,
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
            const SizedBox(height: 30),

            // Controls
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                // Rewind 10s
                GestureDetector(
                  onTap: seekBackward,
                  child: Container(
                    width: 40,
                    height: 40,
                    decoration: const BoxDecoration(
                      // color: Colors.white24,
                      shape: BoxShape.circle,
                    ),
                    alignment: Alignment.center,
                    child: const Icon(
                      Icons.replay_10,
                      color: Colors.white,
                      size: 30,
                    ),
                  ),
                ),

                // Play/Pause
                GestureDetector(
                  onTap: playPause,
                  child: Container(
                    width: 60,
                    height: 60,
                    decoration: const BoxDecoration(
                      color: Colors.white,
                      shape: BoxShape.circle,
                    ),
                    alignment: Alignment.center,
                    child: Icon(
                      isPlaying ? Icons.pause : Icons.play_arrow,
                      color: Colors.black,
                      size: 36,
                    ),
                  ),
                ),

                // Forward 10s
                GestureDetector(
                  onTap: seekForward,
                  child: Container(
                    width: 40,
                    height: 40,
                    decoration: const BoxDecoration(
                      // color: Colors.white24,
                      shape: BoxShape.circle,
                    ),
                    alignment: Alignment.center,
                    child: const Icon(
                      Icons.forward_10,
                      color: Colors.white,
                      size: 30,
                    ),
                  ),
                ),
              ],
            ),
            const Spacer(),
          ],
        ),
      ),
    );
  }
}
