import 'package:dreamscenter/default_colors.dart';
import 'package:dreamscenter/player/player_model.dart';
import 'package:dreamscenter/player/syncplay/syncplay_model.dart';
import 'package:dreamscenter/widgets/interaction_detector.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class SyncplayInsideRoom extends StatelessWidget {
  const SyncplayInsideRoom({super.key});

  @override
  Widget build(BuildContext context) {
    final model = context.watch<SyncplayModel>();
    final playerModel = context.read<PlayerModel>();
    return Row(mainAxisSize: MainAxisSize.min, children: [
      SizedBox(
        height: 400,
        width: 200,
        child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
          const Text(
            'Users: ',
            style: TextStyle(color: Colors.white),
          ),
          for (final user in model.users)
            Text(
              user,
              style: TextStyle(
                color: Colors.white,
                fontWeight: user == model.currentUser ? FontWeight.bold : FontWeight.normal,
              ),
            ),
        ]),
      ),
      const SizedBox(width: 20),
      SizedBox(
        height: 400,
        width: 500,
        child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
          for (final url in model.urls)
            Container(
              margin: const EdgeInsets.only(bottom: 15),
              child: InteractionDetector(
                showClickCursor: true,
                onTap: () => playerModel.source = url,
                child: Text(
                  url,
                  style: TextStyle(
                    color: url == playerModel.source ? Colors.blue : Colors.white,
                    fontWeight: url == playerModel.source ? FontWeight.bold : FontWeight.normal,
                  ),
                ),
              ),
            ),
          TextField(
            style: const TextStyle(color: Colors.white),
            decoration: const InputDecoration(
              border: OutlineInputBorder(),
              focusedBorder: OutlineInputBorder(
                borderSide: BorderSide(color: DefaultColors.primaryDark),
              ),
              labelText: 'URL',
              hintStyle: TextStyle(color: DefaultColors.primaryDark),
            ),
            onSubmitted: (value) => {
              model.urls = [...model.urls, value],
            },
          ),
        ]),
      ),
    ]);
  }
}
