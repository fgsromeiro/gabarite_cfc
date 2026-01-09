extension StringExtension on String {
  String toReadable() {
    final withSpaces = replaceAllMapped(
      RegExp(r'([A-Z])'),
      (match) => ' ${match.group(0)}',
    );

    return withSpaces
        .trim()
        .split(' ')
        .map((word) =>
            word[0].toUpperCase() + word.substring(1).toLowerCase())
        .join(' ');
  }
}