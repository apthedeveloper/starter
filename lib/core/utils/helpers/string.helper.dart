final class Search {
  List<String> fuzzySearch(String query, List<String> data) {
    query = query.toLowerCase();

    return data.where((item) {
      final text = item.toLowerCase();

      if (text.contains(query)) return true;

      int qIndex = 0;

      for (int i = 0; i < text.length && qIndex < query.length; i++) {
        if (text[i] == query[qIndex]) {
          qIndex++;
        }
      }

      return qIndex == query.length;
    }).toList();
  }
}
