import 'package:flutter/material.dart';

import '../constants/color.dart';

class PasswordStrengthIndicator extends StatelessWidget {
  final bool hasUppercase;
  final bool hasLowercase;
  final bool hasDigits;
  final bool hasSpecialCharacters;

  PasswordStrengthIndicator({
    required this.hasUppercase,
    required this.hasLowercase,
    required this.hasDigits,
    required this.hasSpecialCharacters,
  });

  @override
  Widget build(BuildContext context) {
    int strength = 0;

    if (hasUppercase) strength++;
    if (hasLowercase) strength++;
    if (hasDigits) strength++;
    if (hasSpecialCharacters) strength++;

    return Column(
      mainAxisAlignment: MainAxisAlignment.start,
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            _buildStrengthIndicator(strength, 1),
            _buildStrengthIndicator(strength, 2),
            _buildStrengthIndicator(strength, 3),
            _buildStrengthIndicator(strength, 4),
          ],
        ),
      ],
    );
  }

  Widget _buildStrengthIndicator(int strength, int indicator) {
    return Container(
      margin: const EdgeInsets.all(2),
      width: 40,
      height: 5,
      decoration: BoxDecoration(
        color: strength >= indicator && strength >= 3
            ? Colors.greenAccent
            : strength >= indicator && strength <= 2
                ? AppColors.main3
                : AppColors.text3,
        borderRadius: BorderRadius.circular(2.5),
      ),
    );
  }
}
