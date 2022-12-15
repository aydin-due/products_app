import 'package:flutter/material.dart';

class AuthBackground extends StatelessWidget {
  const AuthBackground({super.key, required this.child});

  final Widget child;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
        width: double.infinity,
        height: double.infinity,
        child: Stack(children: [const _PurpleBox(), const HeaderIcon(), child]));
  }
}

class HeaderIcon extends StatelessWidget {
  const HeaderIcon({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Container(
        margin: const EdgeInsets.only(top: 30),
        width: double.infinity,
        child: const Icon(Icons.person_pin, color: Colors.white, size: 100),
      ),
    );
  }
}

class _PurpleBox extends StatelessWidget {
  const _PurpleBox({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final Size size = MediaQuery.of(context).size;

    return Container(
      width: double.infinity,
      height: size.height * 0.4,
      decoration: _purpleBg(),
      child: Stack(children: const [
        Positioned(
          top: 90,
          left: 30,
          child: _Bubble(),
        ),
        Positioned(
          top: -40,
          left: -30,
          child: _Bubble(),
        ),
        Positioned(
          top: -50,
          right: -20,
          child: _Bubble(),
        ),
        Positioned(
          bottom: -50,
          left: 10,
          child: _Bubble(),
        ),
        Positioned(
          bottom: 120,
          right: 20,
          child: _Bubble(),
        ),
      ]),
    );
  }

  BoxDecoration _purpleBg() => const BoxDecoration(
        gradient: LinearGradient(colors: [
          Color.fromRGBO(63, 63, 156, 1),
          Color.fromRGBO(90, 70, 178, 1)
        ]),
      );
}

class _Bubble extends StatelessWidget {
  const _Bubble({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 100,
      height: 100,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(100),
        color: const Color.fromRGBO(255, 255, 255, 0.05),
      ),
    );
  }
}
