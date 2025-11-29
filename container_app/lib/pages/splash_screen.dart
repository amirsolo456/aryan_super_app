import 'package:flutter/material.dart';
import 'package:ui_components_package/erp_app_componenets/common/aryan_logo.dart';
import 'home_wrapper.dart';

class SplashScreenPage extends StatefulWidget {
  const SplashScreenPage({super.key});

  @override
  State<SplashScreenPage> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreenPage>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  late Animation<double> _translateY;
  late Animation<double> _opacity;

  bool _loaderVisible = false;
  bool _minimumTimeElapsed = false;
  bool _isNavigating = false;

  @override
  void initState() {
    super.initState();

    _controller = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 800),
    );

    _translateY = Tween<double>(
      begin: 100,
      end: -100,
    ).animate(CurvedAnimation(parent: _controller, curve: Curves.easeInOut));

    _opacity = Tween<double>(
      begin: 0,
      end: 1,
    ).animate(CurvedAnimation(parent: _controller, curve: Curves.easeIn));

    _startMinimumTimer();
    _startAnimation();
  }

  void _startMinimumTimer() {
    Future.delayed(const Duration(seconds: 5), () {
      if (!mounted) return;
      setState(() => _minimumTimeElapsed = true);
      _navigateToHomeWrapper();
    });
  }

  void _startAnimation() async {
    try {
      await Future.delayed(const Duration(milliseconds: 1000));
      if (!mounted) return;

      await _controller.forward();

      if (!mounted) return;

      setState(() => _loaderVisible = true);
    } catch (e) {
      print('Animation error: $e');
      if (_minimumTimeElapsed && !_isNavigating) {
        _navigateToHomeWrapper();
      }
    }
  }

  void _navigateToHomeWrapper() {
    if (_isNavigating || !mounted) return;
    _isNavigating = true;

    Future.delayed(const Duration(milliseconds: 1000), () {
      if (!mounted) return;

      Navigator.of(context).pushAndRemoveUntil(
        MaterialPageRoute(builder: (_) => const HomeWrapper()),
        (route) => false,
      );
    });
  }

  @override
  void dispose() {
    _isNavigating = true;
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: Center(
        child: AnimatedBuilder(
          animation: _controller,
          builder: (context, child) => Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Transform.translate(
                offset: Offset(0, _translateY.value),
                child: Opacity(opacity: _opacity.value, child: AryanLogo()),
              ),
              const SizedBox(height: 40),
              if (_loaderVisible)
                const CircularProgressIndicator(
                  color: Colors.black,
                  strokeAlign: 3,
                  padding: EdgeInsetsGeometry.all(5),
                  strokeCap: StrokeCap.round,
                  trackGap: 1,
                  strokeWidth: 3,
                ),
            ],
          ),
        ),
      ),
    );
  }
}
