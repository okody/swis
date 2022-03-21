String getSubString(String str, int limit, {int start = 0}) {
  String newStr = "";

  for (int i = start; i < limit; i++) {
    newStr = newStr + str[i];
  }

  return newStr + "...";
}
