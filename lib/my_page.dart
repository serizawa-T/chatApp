import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:google_sign_in/google_sign_in.dart';

import 'signin_page.dart';

class MyPage extends StatelessWidget {
  const MyPage({super.key});

  @override
  Widget build(BuildContext context) {
    final user = FirebaseAuth.instance.currentUser!;
    return Scaffold(
      appBar: AppBar(
        title: const Text('マイページ'),
        actions: [
          // ElevatedButton(
          //   onPressed: () {},
          //   child: const Text('サインアウト'),
          // ),
          IconButton(
              onPressed: () async {
                // Google からサインアウト
                await GoogleSignIn().signOut();
                // Firebase からサインアウト
                await FirebaseAuth.instance.signOut();
                // SignInPage に遷移
                // このページには戻れないようにします。
                Navigator.of(context).pushAndRemoveUntil(
                  MaterialPageRoute(builder: (context) {
                    return const SignInPage();
                  }),
                  (route) => false,
                );
              },
              icon: Icon(Icons.logout))
        ],
      ),
      body: Column(children: [
        Container(
            width: double.infinity,
            height: 200,
            // color: Colors.red,
            child: Stack(
              children: [
                Padding(
                  padding: const EdgeInsets.only(bottom: 40),
                  child: Container(
                    decoration: BoxDecoration(
                      color: Colors.black,
                      image: DecorationImage(
                        image: NetworkImage(
                            'https://beiz.jp/images_S/yellow/yellow_00080.jpg'),
                        fit: BoxFit.cover,
                      ),
                    ),
                  ),
                ),
                Align(
                  alignment: Alignment.bottomCenter,
                  child: CircleAvatar(
                    backgroundImage: NetworkImage(user.photoURL!),
                    radius: 60,
                  ),
                )
              ],
            )),
        SizedBox(
          height: 20,
        ),
        Text(
          user.displayName!,
          style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
        ),
        SizedBox(
          height: 5,
        ),
        Text(
          '@${user.uid}',
          style: TextStyle(
              fontSize: 16, fontWeight: FontWeight.bold, color: Colors.grey),
        ),
        SizedBox(
          height: 20,
        ),
        Text(
          '登録日:${user.metadata.creationTime!}',
          style: TextStyle(fontSize: 16, color: Colors.grey),
        ),
      ]),
    );
  }
}
