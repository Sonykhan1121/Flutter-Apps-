import 'dart:math' as math;

import 'package:flutter/material.dart';
class DesignSearchScreen extends StatelessWidget {
  const DesignSearchScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back_ios, color: Colors.black54),
          onPressed: () {},
        ),
        title: const Text(
          'Find Device',
          style: TextStyle(color: Colors.black87),
        ),
      ),
      body: const Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            SizedBox(height: 40),
            SearchingAnimation(),
            SizedBox(height: 40),
            Text(
              'Searching......',
              style: TextStyle(
                color: Colors.black87,
                fontSize: 16,
              ),
            ),
            Spacer(),
          ],
        ),
      ),
    );
  }
}

class SearchingAnimation extends StatefulWidget {
  const SearchingAnimation({super.key});

  @override
  State<SearchingAnimation> createState() => _SearchingAnimationState();
}

class _SearchingAnimationState extends State<SearchingAnimation> with SingleTickerProviderStateMixin {
  late AnimationController _controller;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      vsync: this,
      duration: const Duration(seconds: 2),
    )..repeat();
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: 280,
      height: 280,
      child: Stack(
        alignment: Alignment.center,
        children: [
          // Small blue dot indicator
          Positioned(
            right: 90,
            top: 90,
            child: Container(
              width: 4,
              height: 4,
              decoration: const BoxDecoration(
                color: Color(0xFF003366),
                shape: BoxShape.circle,
              ),
            ),
          ),
          // Ripple animation layers
          ...List.generate(4, (index) {
            return AnimatedBuilder(
              animation: _controller,
              builder: (context, child) {
                final animationProgress = _controller.value;
                final delay = index / 4;
                final adjustedProgress = (animationProgress + delay) % 1.0;

                return Opacity(
                  opacity: 1.0 - adjustedProgress,
                  child: Transform.scale(
                    scale: 0.5 + (adjustedProgress * 0.5),
                    child: Container(
                      width: 200,
                      height: 200,
                      decoration: BoxDecoration(
                        shape: BoxShape.circle,
                        color: const Color(0xFFE6F0F5).withOpacity(0.8 - (adjustedProgress * 0.6)),
                      ),
                    ),
                  ),
                );
              },
            );
          }),
          // Center blue dot
          Container(
            width: 30,
            height: 30,
            decoration: const BoxDecoration(
              color: Color(0xFF003366),
              shape: BoxShape.circle,
            ),
          ),
        ],
      ),
    );
  }
}