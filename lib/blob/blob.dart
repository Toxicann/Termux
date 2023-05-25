import 'dart:math';

import 'package:flutter/material.dart';

class Blob {
  Offset position;
  Offset velocity;

  Blob({required this.position, required this.velocity});
}

class AnimatedBlobsFluttering extends StatefulWidget {
  @override
  _AnimatedBlobsFlutteringState createState() =>
      _AnimatedBlobsFlutteringState();
}

class _AnimatedBlobsFlutteringState extends State<AnimatedBlobsFluttering>
    with SingleTickerProviderStateMixin {
  late AnimationController _animationController;
  List<Blob> _blobs = [];

  @override
  void initState() {
    super.initState();
    _initializeBlobs();
    _animationController = AnimationController(
      duration: const Duration(seconds: 2),
      vsync: this,
    )..repeat(reverse: true);
  }

  @override
  void dispose() {
    _animationController.dispose();
    super.dispose();
  }

  void _initializeBlobs() {
    _blobs = List.generate(
      5,
      (index) => Blob(
        position: const Offset(200.0, 200.0),
        velocity: Offset(Random().nextDouble() * 5, Random().nextDouble() * 10),
      ),
    );
  }

  void _updateBlobs() {
    for (var i = 0; i < _blobs.length; i++) {
      final blob = _blobs[i];
      final newPosition = blob.position + blob.velocity;

      if (newPosition.dy >= MediaQuery.of(context).size.height) {
        // Reverse velocity if the blob reaches the bottom of the screen
        blob.velocity = Offset(blob.velocity.dx, -blob.velocity.dy);
      } else if (newPosition.dy <= 0.0) {
        // Reverse velocity if the blob reaches the top of the screen
        blob.velocity = Offset(blob.velocity.dx, -blob.velocity.dy);
      }

      if (newPosition.dx >= MediaQuery.of(context).size.width) {
        // Reverse velocity if the blob reaches the right of the screen
        blob.velocity = Offset(-blob.velocity.dx, blob.velocity.dy);
      } else if (newPosition.dx <= 0.0) {
        // Reverse velocity if the blob reaches the left of the screen
        blob.velocity = Offset(-blob.velocity.dx, blob.velocity.dy);
      }

      _blobs[i] = Blob(position: newPosition, velocity: blob.velocity);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Animated Blobs Fluttering'),
      ),
      body: AnimatedBuilder(
        animation: _animationController,
        builder: (BuildContext context, Widget? child) {
          _updateBlobs();
          return CustomPaint(
            painter: BlobsPainter(blobs: _blobs),
          );
        },
      ),
    );
  }
}

class BlobsPainter extends CustomPainter {
  final List<Blob> blobs;

  BlobsPainter({required this.blobs});

  @override
  void paint(Canvas canvas, Size size) {
    final paint = Paint()..color = Colors.blue;

    for (final blob in blobs) {
      canvas.drawCircle(blob.position, 20.0, paint);
    }
  }

  @override
  bool shouldRepaint(BlobsPainter oldDelegate) => true;
}
