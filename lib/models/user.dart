class User {
  int xp = 0;
  int level = 1;

  void calculateLevel() {
    level = (xp ~/ 100) + 1;
  }
}
