import 'package:flutter/material.dart';

class LihatMember extends StatelessWidget {
  const LihatMember({Key? key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Member',
        ),
      ),
      body: ListView(
        children: [
          ListTile(
            title: Text('Member 1'),
            subtitle: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text('0897865643254'),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
