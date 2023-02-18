import 'package:dreamscenter/default_colors.dart';
import 'package:dreamscenter/player/player_model.dart';
import 'package:dreamscenter/player/syncplay/syncplay_client.dart';
import 'package:dreamscenter/player/syncplay/syncplay_model.dart';
import 'package:dreamscenter/util.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class SyncplayOutsideRoom extends StatefulWidget {
  const SyncplayOutsideRoom({super.key});

  @override
  State<SyncplayOutsideRoom> createState() => _SyncplayOutsideRoomState();
}

class _SyncplayOutsideRoomState extends State<SyncplayOutsideRoom> {
  late TextEditingController serverAddressController;

  late TextEditingController serverPasswordController;

  late TextEditingController usernameController;

  late TextEditingController roomController;

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
    const spacing = 10.0;
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        _textField('Server address', (controller) => serverAddressController = controller,
            initialValue: "syncplay.pl:8997"),
        const SizedBox(height: spacing),
        _textField('Server password', (controller) => serverPasswordController = controller),
        const SizedBox(height: spacing),
        _textField('Username', (controller) => usernameController = controller),
        const SizedBox(height: spacing),
        _textField('Room', (controller) => roomController = controller, initialValue: "Dreamscenter"),
      ],
    );
  }

  _textField(String label, void Function(TextEditingController) updateController, {String? initialValue}) {
    return Autocomplete<String>(
        optionsBuilder: (TextEditingValue textEditingValue) {
          return [];
        },
        initialValue: initialValue != null ? TextEditingValue(text: initialValue) : null,
        fieldViewBuilder: (context, controller, focusNode, onFieldSubmitted) {
          updateController(controller);
          return TextField(
            controller: controller,
            style: const TextStyle(color: Colors.white),
            decoration: InputDecoration(
              labelText: label,
              filled: true,
              labelStyle: const TextStyle(color: Colors.white),
              fillColor: Colors.black.withOpacity(0.1),
              focusedBorder: const UnderlineInputBorder(
                borderSide: BorderSide(color: DefaultColors.primaryDark),
              ),
            ),
          );
        });
  }

  _enterRoom(BuildContext context) {
    final playerModel = context.read<PlayerModel>();
    final syncplayModel = context.read<SyncplayModel>();
    return OutlinedButton(
      onPressed: () {
        syncplayModel.client = SyncplayClient(playerModel, syncplayModel);
        syncplayModel.client!.start(
          serverAddress: serverAddressController.text,
          serverPassword: serverPasswordController.text,
          username: usernameController.text,
          room: roomController.text,
        );
        syncplayModel.isInsideRoom = true;
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
