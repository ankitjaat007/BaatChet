class BreakPoint {
  int fontsize = 20;
}

class SmMobile extends BreakPoint {
  @override
  // TODO: implement fontsize
  int get fontsize => 10;
}

class LgMobile extends BreakPoint {
  @override
  // TODO: implement fontsize
  int get fontsize => 30;
}

final _sgmobile = SmMobile();
final _lgmobile = LgMobile();

class getresposive {
  static final getresposive _resposive = getresposive._resposive;

  getResponsiveView() {}
}
