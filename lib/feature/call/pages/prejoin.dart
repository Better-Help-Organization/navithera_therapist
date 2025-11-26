import 'dart:async';
import 'dart:math' as math;

import 'package:dropdown_button2/dropdown_button2.dart';
import 'package:flutter/material.dart';
import 'package:livekit_client/livekit_client.dart';
import 'package:navicare/feature/call/exts.dart';
// import 'package:navithera_client/feature/call/utils.dart';

// import '../theme.dart';
import 'room.dart';

class JoinArgs {
  JoinArgs({
    required this.url,
    required this.token,
    this.e2ee = false,
    this.e2eeKey,
    this.simulcast = true,
    this.adaptiveStream = true,
    this.dynacast = true,
    this.preferredCodec = 'VP8',
    this.enableBackupVideoCodec = true,
  });
  final String url;
  final String token;
  final bool e2ee;
  final String? e2eeKey;
  final bool simulcast;
  final bool adaptiveStream;
  final bool dynacast;
  final String preferredCodec;
  final bool enableBackupVideoCodec;
}

class PreJoinPage extends StatefulWidget {
  const PreJoinPage({required this.args, super.key});
  final JoinArgs args;
  @override
  State<StatefulWidget> createState() => _PreJoinPageState();
}

class _PreJoinPageState extends State<PreJoinPage> {
  List<MediaDevice> _audioInputs = [];
  List<MediaDevice> _videoInputs = [];
  StreamSubscription? _subscription;

  bool _busy = false;
  bool _enableVideo = true;
  bool _enableAudio = true;
  LocalAudioTrack? _audioTrack;
  LocalVideoTrack? _videoTrack;

  @override
  void initState() {
    super.initState();
    print("widget.args: ${widget.args.preferredCodec}");
    _subscription = Hardware.instance.onDeviceChange.stream.listen(
      _loadDevices,
    );
    unawaited(Hardware.instance.enumerateDevices().then(_loadDevices));
  }

  @override
  void deactivate() {
    unawaited(_subscription?.cancel());
    super.deactivate();
  }

  void _loadDevices(List<MediaDevice> devices) async {
    _audioInputs = devices.where((d) => d.kind == 'audioinput').toList();
    _videoInputs = devices.where((d) => d.kind == 'videoinput').toList();

    // Automatically use front camera if available, otherwise use first camera
    MediaDevice? frontCamera;
    MediaDevice? defaultAudio;

    // Find front camera
    for (var device in _videoInputs) {
      if (device.label.toLowerCase().contains('front') ||
          device.deviceId.toLowerCase().contains('front')) {
        frontCamera = device;
        break;
      }
    }

    // Use front camera if found, otherwise use first available camera
    if (_videoInputs.isNotEmpty) {
      await _changeLocalVideoTrack(device: frontCamera ?? _videoInputs.first);
    }

    // Use default audio device (first available)
    if (_audioInputs.isNotEmpty) {
      await _changeLocalAudioTrack(device: _audioInputs.first);
    }

    setState(() {});
  }

  Future<void> _setEnableVideo(value) async {
    _enableVideo = value;
    if (!_enableVideo) {
      await _videoTrack?.stop();
      _videoTrack = null;
    } else {
      // Automatically use front camera when enabling video
      MediaDevice? frontCamera;
      for (var device in _videoInputs) {
        if (device.label.toLowerCase().contains('front') ||
            device.deviceId.toLowerCase().contains('front')) {
          frontCamera = device;
          break;
        }
      }
      await _changeLocalVideoTrack(device: frontCamera ?? _videoInputs.first);
    }
    setState(() {});
  }

  Future<void> _setEnableAudio(value) async {
    _enableAudio = value;
    if (!_enableAudio) {
      await _audioTrack?.stop();
      _audioTrack = null;
    } else {
      // Automatically use default audio device
      await _changeLocalAudioTrack(
        device: _audioInputs.isNotEmpty ? _audioInputs.first : null,
      );
    }
    setState(() {});
  }

  Future<void> _changeLocalAudioTrack({MediaDevice? device}) async {
    if (_audioTrack != null) {
      await _audioTrack!.stop();
      _audioTrack = null;
    }

    if (device != null && _enableAudio) {
      _audioTrack = await LocalAudioTrack.create(
        AudioCaptureOptions(deviceId: device.deviceId),
      );
      await _audioTrack!.start();
    }
  }

  Future<void> _changeLocalVideoTrack({MediaDevice? device}) async {
    if (_videoTrack != null) {
      await _videoTrack!.stop();
      _videoTrack = null;
    }

    if (device != null && _enableVideo) {
      _videoTrack = await LocalVideoTrack.createCameraTrack(
        CameraCaptureOptions(
          deviceId: device.deviceId,
          params: VideoParametersPresets.h720_169,
        ),
      );
      await _videoTrack!.start();
    }
  }

  @override
  void dispose() {
    unawaited(_subscription?.cancel());
    super.dispose();
  }

  _join(BuildContext context) async {
    _busy = true;
    setState(() {});

    final args = widget.args;

    try {
      //create new room
      const cameraEncoding = VideoEncoding(
        maxBitrate: 5 * 1000 * 1000,
        maxFramerate: 30,
      );

      const screenEncoding = VideoEncoding(
        maxBitrate: 3 * 1000 * 1000,
        maxFramerate: 15,
      );

      // E2EEOptions? e2eeOptions;
      // if (args.e2ee && args.e2eeKey != null) {
      //   final keyProvider = await BaseKeyProvider.create();
      //   e2eeOptions = E2EEOptions(keyProvider: keyProvider);
      //   await keyProvider.setKey(args.e2eeKey!);
      // }

      final room = Room(
        roomOptions: RoomOptions(
          // adaptiveStream: args.adaptiveStream,
          adaptiveStream: true,
          dynacast: true,
          defaultAudioPublishOptions: const AudioPublishOptions(
            name: 'custom_audio_track_name',
          ),
          defaultCameraCaptureOptions: const CameraCaptureOptions(
            maxFrameRate: 30,
            params: VideoParameters(dimensions: VideoDimensions(1280, 720)),
          ),
          // defaultScreenShareCaptureOptions: const ScreenShareCaptureOptions(
          //     useiOSBroadcastExtension: true,
          //     params: VideoParameters(
          //       dimensions: VideoDimensionsPresets.h1080_169,
          //     )),
          defaultVideoPublishOptions: VideoPublishOptions(
            simulcast: false,
            // simulcast: args.simulcast,
            videoCodec: args.preferredCodec,

            videoEncoding: cameraEncoding,
            screenShareEncoding: screenEncoding,
          ),
          // encryption: e2eeOptions,
        ),
      );
      // Create a Listener before connecting
      final listener = room.createListener();

      await room.prepareConnection(args.url, args.token);

      // Try to connect to the room
      // This will throw an Exception if it fails for any reason.
      await room.connect(
        args.url,
        args.token,
        fastConnectOptions: FastConnectOptions(
          microphone: TrackOption(track: _audioTrack),
          camera: TrackOption(track: _videoTrack),
        ),
      );

      if (!context.mounted) return;
      await Navigator.push<void>(
        context,
        MaterialPageRoute(builder: (_) => RoomPage(room, listener)),
      );
    } catch (error) {
      print('Could not connect $error');
      if (!context.mounted) return;
      await context.showErrorDialog(error);
    } finally {
      setState(() {
        _busy = false;
      });
    }
  }

  void _actionBack(BuildContext context) async {
    await _setEnableVideo(false);
    await _setEnableAudio(false);
    if (!context.mounted) return;
    Navigator.of(context).pop();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'Join Call',
          // style: TextStyle(color: Colors.white)
        ),
        leading: IconButton(
          icon: const Icon(
            Icons.arrow_back,
            // color: Colors.white
          ),
          onPressed: () => _actionBack(context),
        ),
      ),
      body: Container(
        alignment: Alignment.center,
        child: SingleChildScrollView(
          child: Container(
            padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 20),
            constraints: const BoxConstraints(maxWidth: 400),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                Padding(
                  padding: const EdgeInsets.only(bottom: 10),
                  child: SizedBox(
                    width: 320,
                    height: 240,
                    child: Container(
                      alignment: Alignment.center,
                      color: Colors.black54,
                      child:
                          _videoTrack != null
                              ? VideoTrackRenderer(
                                renderMode: VideoRenderMode.auto,
                                _videoTrack!,
                              )
                              : Container(
                                alignment: Alignment.center,
                                child: LayoutBuilder(
                                  builder:
                                      (ctx, constraints) => Icon(
                                        Icons.videocam_off,
                                        // color: LKColors.lkBlue,
                                        size:
                                            math.min(
                                              constraints.maxHeight,
                                              constraints.maxWidth,
                                            ) *
                                            0.3,
                                      ),
                                ),
                              ),
                    ),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.only(bottom: 25),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      const Text('Camera', style: TextStyle(fontSize: 16)),
                      Switch(
                        value: _enableVideo,
                        onChanged: (value) => _setEnableVideo(value),
                      ),
                    ],
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.only(bottom: 25),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      const Text('Microphone', style: TextStyle(fontSize: 16)),
                      Switch(
                        value: _enableAudio,
                        onChanged: (value) => _setEnableAudio(value),
                      ),
                    ],
                  ),
                ),
                ElevatedButton(
                  onPressed: _busy ? null : () => _join(context),
                  child: Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      if (_busy)
                        const Padding(
                          padding: EdgeInsets.only(right: 10),
                          child: SizedBox(
                            height: 15,
                            width: 15,
                            child: CircularProgressIndicator(
                              color: Colors.white,
                              strokeWidth: 2,
                            ),
                          ),
                        ),
                      const Text('JOIN'),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
