const characterSet = [
  '0' '1' '2' '3' '4' '5' '6' '7' '8' '9' '-' '_' '.',
  'a' 'b' 'c' 'd' 'e' 'f' 'g' 'h' 'i' 'j' 'k' 'l' 'm',
  'n' 'o' 'p' 'q' 'r' 's' 't' 'u' 'v' 'w' 'x' 'y' 'z',
  'A' 'B' 'C' 'D' 'E' 'F' 'G' 'H' 'I' 'J' 'K' 'L' 'M',
  'N' 'O' 'P' 'Q' 'R' 'S' 'T' 'U' 'V' 'W' 'X' 'Y' 'Z',
];

const magicLinkBaseUrl = 'https://dreamscenter.app/m/';

class MagicLinkException implements Exception {
  final String message;

  MagicLinkException(this.message);
}

int getMagicLinkVersion(String link) {
  if (!link.startsWith(magicLinkBaseUrl)) {
    throw MagicLinkException('Invalid magic link: $link');
  }

  final encodedPart = link.substring(magicLinkBaseUrl.length);
  final split = link.split('.');

  return 0;
}
