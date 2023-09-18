import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:scribbleverse/domain/provider/poems/writting_provider.dart';

class DrawingBoard extends StatefulWidget {
  const DrawingBoard({super.key});

  @override
  // ignore: library_private_types_in_public_api
  _DrawingBoardState createState() => _DrawingBoardState();
}

class _DrawingBoardState extends State<DrawingBoard> {
  @override
  Widget build(BuildContext context) {
    final drawingProvider = Provider.of<DrawingProvider>(context);

    return GestureDetector(
      onPanUpdate: (details) {
        setState(() {
          drawingProvider.addPoint(details.localPosition);
        });
      },
      onPanEnd: (_) {
        drawingProvider.addPoint(Offset.infinite);
      },
      child: CustomPaint(
        painter: DrawingPainter(drawingProvider.points),
      ),
    );
  }
}

class DrawingPainter extends CustomPainter {
  final List<Offset> points;

  DrawingPainter(this.points);

  @override
  void paint(Canvas canvas, Size size) {
    for (int i = 0; i < points.length; i++) {
      if (points[i] != null) {
        Paint paint = Paint()
          ..color = Colors.black
          ..strokeCap = StrokeCap.round
          ..strokeWidth = 5.0;

        if (i == points.length - 1) {
          canvas.drawPoints(PointMode.points, [points[i]], paint);
        } else {
          canvas.drawLine(points[i], points[i + 1], paint);
        }
      }
    }
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) {
    return true;
  }
}

class Writter extends StatelessWidget {
  const Writter({super.key});

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (context) => DrawingProvider(),
      child: MaterialApp(
        title: 'Drawing Board',
        theme: ThemeData(
          primarySwatch: Colors.blue,
        ),
        home: Scaffold(
          appBar: AppBar(
            title: const Text('Drawing Board'),
          ),
          body: const DrawingBoard(),
        ),
      ),
    );
  }
}
