String _getLink(String name) {
  return 'assets/svgs/$name.svg';
}

abstract final class SvgAssets {
  static String messageFill = _getLink('message_fill');
  static String eyeStroke = _getLink('eye_stroke');
  static String eyeOffStroke = _getLink('eye-off_stroke');
}
