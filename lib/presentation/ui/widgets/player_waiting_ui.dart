import 'package:flutter/cupertino.dart';

import '../../../config/colors.dart';
import '../../../config/spacing.dart';
import '../../../network/model/Player.dart';
import 'common.dart';

class PlayerWaitingUi extends StatefulWidget {
  final List<String> messages;
  final GamePlayer? you;
  final GamePlayer? opponent;

  const PlayerWaitingUi({
    super.key,
    required this.messages,
    this.you,
    this.opponent,
  });

  @override
  PlayerWaitingUiState createState() => PlayerWaitingUiState();
}

class PlayerWaitingUiState extends State<PlayerWaitingUi> {
  int _currentMessageIndex = 0;

  @override
  void initState() {
    super.initState();
    _startMessageSwitcher();
  }

  void _startMessageSwitcher() {
    if (widget.messages.length > 1) {
      Future.delayed(const Duration(seconds: 3), () {
        if (mounted) {
          setState(() {
            _currentMessageIndex =
                (_currentMessageIndex + 1) % widget.messages.length;
          });
          _startMessageSwitcher();
        }
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 24),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              if (widget.you != null) ...[
                PlayerCardUi(
                  imageUrl: "",
                  avatarUrl: widget.you?.avatar,
                  playerName: "You",
                  rating: widget.you!.rating.toString(),
                ),
                const SizedBox(width: AppSpacing.medium),
                MessageUi('V/s', color: AppColors.success),
                const SizedBox(width: AppSpacing.medium),
              ],
              PlayerCardUi(
                imageUrl: "",
                avatarUrl: widget.opponent?.avatar,
                playerName: widget.opponent?.username,
                rating: widget.opponent?.rating.toString(),
              ),
            ],
          ),
          const SizedBox(height: AppSpacing.large),
          AnimatedSwitcher(
            duration: const Duration(milliseconds: 300),
            transitionBuilder: (Widget child, Animation<double> animation) {
              return FadeTransition(
                opacity: animation,
                child: child,
              );
            },
            child: Text(
              widget.messages[_currentMessageIndex],
              key: ValueKey<String>(widget.messages[_currentMessageIndex]),
              style:
                  const TextStyle(fontSize: 16.0, color: AppColors.onPrimary),
            ),
          ),
        ],
      ),
    );
  }
}
