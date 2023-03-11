import 'package:dreamscenter/default_colors.dart';
import 'package:dreamscenter/player/player_view_model.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class SourcePopup extends StatefulWidget {
  const SourcePopup({super.key});

  @override
  State<SourcePopup> createState() => _SourcePopupState();
}

class _SourcePopupState extends State<SourcePopup> {
  final textController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    final viewModel = context.read<PlayerViewModel>();
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
              viewModel.source = url;
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
