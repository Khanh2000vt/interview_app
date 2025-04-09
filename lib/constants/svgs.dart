String _getLink(String name) {
  return 'assets/svgs/$name.svg';
}

final class SvgAssets {
  final String messageFill = _getLink('message_fill');
  final String eyeStroke = _getLink('eye_stroke');
  final String eyeOffStroke = _getLink('eye-off_stroke');
}
