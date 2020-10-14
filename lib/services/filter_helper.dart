class FilterHelper {
  // list must contain map item that contain key name (lowercase) and tags (lowercase)
  static Future<List<Map>> applyFilter(
      List<Map> source, List<Map> category, String query) async {
    List<String> splitQuery = query.toLowerCase().split(' ');
    List<Map<String, int>> confidence = List<Map<String, int>>.generate(
      source.length,
      (index) => {
        'id': index,
        'val': 0,
      },
    );
    for (String q in splitQuery) {
      for (int i = 0; i < source.length; i++) {
        if (source[i]['lower'].contains(q)) confidence[i]['val']++;
        if (category[source[i]['idCategory']]['t'].contains(q))
          confidence[i]['val']++;
      }
    }
    confidence.removeWhere((e) => e['val'] < 2);
    confidence.sort((a, b) => b['val'].compareTo(a['val']));
    List<Map> result = [];
    for (Map<String, int> c in confidence) result.add(source[c['id']]);
    return result;
  }
}
