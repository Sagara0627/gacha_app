import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
// import 'package:gacha_app/widgets/common_layout.dart';

class GachaManagePage extends ConsumerWidget {
  const GachaManagePage({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {

    return Scaffold(
      appBar: AppBar(title: const Text('ガチャ管理')),
      // body: CommonLayout(),
    );
  }
}
