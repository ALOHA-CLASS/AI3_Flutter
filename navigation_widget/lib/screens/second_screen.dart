import 'package:flutter/material.dart';

class SecondScreen extends StatelessWidget {
  const SecondScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Second Screen"),
      ),
      body: Center(
        child: ElevatedButton(
          onPressed: () {
            // 화면이동 방법 2 - 스택에 쌓인 스크린 제거
            Navigator.pop(context);
          },
          child: const Text("Go back to First Screen"),
        ),
      ),
    );
  }
}