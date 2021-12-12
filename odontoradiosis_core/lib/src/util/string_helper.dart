abstract class StringHelper {
  static String valueBetweenParenthesis(final String original) {
    final buffer = StringBuffer();
    var hasFoundParenthesis = false;
    for (final character in original.codeUnits) {
      if (hasFoundParenthesis) {
        buffer.writeCharCode(character);
        if (character == 41) {
          return buffer.toString();
        }
      }
      if (character == 40) {
        hasFoundParenthesis = true;
      }
    }
    return buffer.toString();
  }
}
