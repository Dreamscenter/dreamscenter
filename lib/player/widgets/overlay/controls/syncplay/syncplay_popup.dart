import 'package:dreamscenter/default_colors.dart';
import 'package:dreamscenter/player/player_model.dart';
import 'package:dreamscenter/player/syncplay/syncplay_client.dart';
import 'package:dreamscenter/util.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class SyncplayPopup extends StatelessWidget {
  const SyncplayPopup({super.key});

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: 400,
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          _form(),
          const SizedBox(height: 20),
          _enterRoom(context),
        ],
      ),
    );
  }

  _form() {
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        _textField('Server address'),
        _textField('Server password (if any)'),
        _textField('Username'),
        _textField('Room'),
      ],
    );
  }

  _textField(String label) {
    return TextField(
      style: const TextStyle(color: Colors.white),
      decoration: InputDecoration(
        labelText: label,
        labelStyle: const TextStyle(color: Colors.white),
        focusedBorder: const UnderlineInputBorder(
          borderSide: BorderSide(color: DefaultColors.primaryDark),
        ),
      ),
    );
  }

  _enterRoom(BuildContext context) {
    final playerModel = context.read<PlayerModel>();
    return OutlinedButton(
      onPressed: () {
        SyncplayClient(playerModel).start(
          serverAddress: 'syncplay.pl',
          serverPassword: null,
          username: 'Gieted (Dreamscenter)',
          room: 'Gieted',
        );
      },
      style: OutlinedButton.styleFrom(
        foregroundColor: DefaultColors.primaryDark,
        backgroundColor: Colors.black.withOpacity(0.1),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.all(Radius.circular(longestSize(context))),
        ),
      ),
      child: const Text('enter room'),
    );
  }
}
