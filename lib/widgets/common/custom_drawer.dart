import 'package:flutter/material.dart';

class CustomDrawer extends StatelessWidget {
  const CustomDrawer({super.key});

  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: ListView(
        children: [
          const DrawerHeader(
            decoration: BoxDecoration(color: Colors.blue),
            child: Text('メニュー', style: TextStyle(color: Colors.white, fontSize: 20)),
          ),
          ListTile(
            leading: const Icon(Icons.list),
            title: const Text('シリーズ一覧'),
            onTap: () {
              // 遷移処理など
            },
          ),
          // アコーディオンメニュー（ExpansionTile）
          ExpansionTile(
            leading: const Icon(Icons.settings),
            title: const Text('設定・その他'),
            children: [
              ListTile(
                title: const Text('ユーザー設定'),
                onTap: () {},
              ),
              ListTile(
                title: const Text('アプリ情報'),
                onTap: () {},
              ),
            ],
          ),
        ],
      ),
    );
  }
}