import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';
import 'package:gacha_app/domains/Entity/gacha_item_entity.dart';

class GachaAnimationScreen extends StatefulWidget {
  final List<GachaItemEntity> results;
  const GachaAnimationScreen({super.key, required this.results});

  @override
  State<GachaAnimationScreen> createState() => _GachaAnimationScreenState();
}

class _GachaAnimationScreenState extends State<GachaAnimationScreen> {
  bool _isFinished = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      body: Center(
        child: _isFinished 
          ? _buildResultList() // アニメが終わったら結果リストを表示
          : Lottie.asset(
              'assets/lottie/gacha_animation.json',
              repeat: false, // 1回だけ再生
              onLoaded: (composition) {
                // アニメーションの時間に合わせて結果を表示
                Future.delayed(composition.duration, () {
                  setState(() => _isFinished = true);
                });
              },
            ),
      ),
    );
  }

  Widget _buildResultList() {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        const Text('GET!!', style: TextStyle(color: Colors.amber, fontSize: 32)),
        // 10連の結果などをリスト表示
        ...widget.results.map((item) => Text(item.name, style: const TextStyle(color: Colors.white))),
        ElevatedButton(
          onPressed: () => Navigator.pop(context), // 画面を閉じる
          child: const Text('戻る'),
        )
      ],
    );
  }
}
