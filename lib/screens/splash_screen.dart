import 'package:avatar_glow/avatar_glow.dart';
import 'package:flutter/material.dart';
import 'package:tic_tac_toe_game/screens/constants/custom_fonts.dart';
import 'package:tic_tac_toe_game/screens/game.dart';

class SplashScreen extends StatelessWidget {
  const SplashScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            AvatarGlow(
              duration: const Duration(seconds: 3),
              glowColor: Colors.white,
              repeat: true,
              repeatPauseDuration: const Duration(seconds: 1),
              startDelay: const Duration(seconds: 1),
              endRadius: 140,
              child: Container(
                decoration: BoxDecoration(
                    border: Border.all(
                      style: BorderStyle.none,
                    ),
                    shape: BoxShape.circle),
                child: CircleAvatar(
                  backgroundColor: Colors.grey[900],
                  child: Image.asset('lib/assets/images/tic_tac_toe.png'),
                ),
              ),
            ),
            Text('Tic Tac Toe', style: customFontsWhite.copyWith(fontSize: 20)),
            const SizedBox(
              height: 25,
            ),
            FilledButton(
              onPressed: () {
                Navigator.of(context).push(MaterialPageRoute(
                    builder: (context) => const GameScreen()));
              },
              style: ButtonStyle(
                  backgroundColor: MaterialStateProperty.all(Colors.grey)),
              child: Text("Let's Play!",
                  style: customFontsBlack.copyWith(fontSize: 10)),
            )
          ],
        ),
      ),
    );
  }
}
