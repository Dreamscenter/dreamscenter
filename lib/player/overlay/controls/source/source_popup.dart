import 'package:dreamscenter/default_colors.dart';
import 'package:dreamscenter/player/player_viewmodel.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class SourcePopup extends StatelessWidget {
  final textController = TextEditingController();

  SourcePopup({super.key});

  @override
  Widget build(BuildContext context) {
    final playerViewModel = context.read<PlayerViewModel>();
    return SizedBox(
      width: 400,
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          TextField(
            style: const TextStyle(color: Colors.white),
            decoration: const InputDecoration(
              labelText: 'url',
              labelStyle: TextStyle(color: Colors.white),
              focusedBorder: UnderlineInputBorder(
                borderSide: BorderSide(color: DefaultColors.primaryDark),
              ),
            ),
            controller: textController,
          ),
          const SizedBox(height: 40),
          OutlinedButton(
            onPressed: () {
              final url = textController.text;
              playerViewModel.source = url;
            },
            style: OutlinedButton.styleFrom(
              foregroundColor: DefaultColors.primaryDark,
              side: const BorderSide(color: DefaultColors.primaryDark),
            ),
            child: const Text("play"),
          ),
        ],
      ),
    );
  }
}
