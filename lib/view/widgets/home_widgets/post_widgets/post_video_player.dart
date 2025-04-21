import 'dart:io';

import 'package:flutter/material.dart';
import 'package:video_player/video_player.dart';

class PostVideoPlayer extends StatefulWidget {
  final String? videoUrl;
  final File? videoFile;

  const PostVideoPlayer({super.key, this.videoUrl, this.videoFile})
      : assert(videoUrl != null || videoFile != null,
            'Either videoUrl or videoFile must be provided');

  @override
  State<PostVideoPlayer> createState() => _PostVideoPlayerState();
}

class _PostVideoPlayerState extends State<PostVideoPlayer> {
  late VideoPlayerController _controller;
  bool _isInitialized = false;

  @override
  void initState() {
    super.initState();
    _controller = widget.videoUrl != null
        ? VideoPlayerController.network(widget.videoUrl!)
        : VideoPlayerController.file(widget.videoFile!);

    _initializeController();
  }

  Future<void> _initializeController() async {
    try {
      await _controller.initialize();
      _controller.setLooping(false);
      _controller.addListener(_videoListener);
      _controller.play(); // Autoplay on load
      setState(() => _isInitialized = true);
    } catch (e) {
      debugPrint('Video initialization failed: $e');
    }
  }

  void _videoListener() {
    if (!mounted) return;

    final isEnded = _controller.value.position >= _controller.value.duration &&
        !_controller.value.isPlaying;

    if (isEnded) {
      _controller.seekTo(Duration.zero);
    }

    setState(() {}); // Force rebuild for play/pause icon update
  }

  void _togglePlayPause() {
    if (_controller.value.isPlaying) {
      _controller.pause();
    } else {
      if (_controller.value.position >= _controller.value.duration) {
        _controller.seekTo(Duration.zero);
      }
      _controller.play();
    }

    setState(() {}); // Immediately update UI
  }

  @override
  Widget build(BuildContext context) {
    if (!_isInitialized) {
      return const Center(child: CircularProgressIndicator());
    }

    final duration = _controller.value.duration;
    final position = _controller.value.position;
    final progress = duration.inMilliseconds > 0
        ? position.inMilliseconds / duration.inMilliseconds
        : 0.0;

    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        GestureDetector(
          onTap: _togglePlayPause,
          child: Stack(
            alignment: Alignment.center,
            children: [
              AspectRatio(
                aspectRatio: _controller.value.aspectRatio,
                child: VideoPlayer(_controller),
              ),
              if (!_controller.value.isPlaying)
                const Icon(
                  Icons.play_circle_fill,
                  size: 64,
                  color: Colors.black,
                ),
            ],
          ),
        ),
        const SizedBox(height: 12),
        LayoutBuilder(
          builder: (context, constraints) {
            final width = constraints.maxWidth;
            final circlePosition = width * progress;

            return GestureDetector(
              onHorizontalDragUpdate: (details) {
                final localDx = details.localPosition.dx.clamp(0.0, width);
                final newPosition = Duration(
                    milliseconds:
                    (duration.inMilliseconds * (localDx / width)).round());
                _controller.seekTo(newPosition);
              },
              onTapDown: (details) {
                final tappedPosition = details.localPosition.dx.clamp(0.0, width);
                final newPosition = Duration(
                    milliseconds:
                    (duration.inMilliseconds * (tappedPosition / width))
                        .round());
                _controller.seekTo(newPosition);
              },
              child: SizedBox(
                height: 24,
                width: width,
                child: Stack(
                  alignment: Alignment.centerLeft,
                  children: [
                    // Background bar
                    Container(
                      height: 4,
                      width: double.infinity,
                      color: Colors.grey.shade300,
                    ),
                    // Played bar
                    Container(
                      height: 4,
                      width: circlePosition,
                      color: Colors.red,
                    ),
                    // Circle indicator
                    Positioned(
                      left: circlePosition - 6,
                      child: Container(
                        width: 12,
                        height: 12,
                        decoration: const BoxDecoration(
                          color: Colors.red,
                          shape: BoxShape.circle,
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            );
          },
        ),
      ],
    );
  }

  @override
  void dispose() {
    _controller.removeListener(_videoListener);
    _controller.dispose();
    super.dispose();
  }
}
