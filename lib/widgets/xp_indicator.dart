import 'package:flutter/material.dart';
import 'package:atividadedouglas/models/user.dart';

class XpIndicator extends StatelessWidget {
  final User user;

  XpIndicator(this.user);

  @override
  Widget build(BuildContext context) {
    int xpNeeded = 100;
    int currentLevelXP = user.xp % xpNeeded;
    int currentLevel = user.level;

    double xpPercentage = currentLevelXP / xpNeeded;

    return Container(
      padding: EdgeInsets.all(16),
      width: double.infinity,
      color: Colors.white,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisSize: MainAxisSize.min,
        children: [
          Container(
            height: 20,
            width: double.infinity,
            child: Stack(
              children: [
                Container(
                  decoration: BoxDecoration(
                    color: Colors.white,
                    border: Border.all(color: Colors.blue),
                    borderRadius: BorderRadius.circular(10),
                  ),
                  child: FractionallySizedBox(
                    widthFactor: xpPercentage,
                    child: Container(
                      decoration: BoxDecoration(
                        color: Colors.blue,
                        borderRadius: BorderRadius.circular(10),
                      ),
                    ),
                  ),
                ),
                Center(
                  child: Text(
                    'XP: $currentLevelXP/$xpNeeded',
                    style: TextStyle(color: Colors.grey),
                    textAlign: TextAlign.center,
                  ),
                ),
              ],
            ),
          ),
          SizedBox(height: 8),
          Text(
            'Nível: $currentLevel',
            style: TextStyle(color: Colors.grey),
            textAlign: TextAlign.center,
          ),
        ],
      ),
    );
  }
}
