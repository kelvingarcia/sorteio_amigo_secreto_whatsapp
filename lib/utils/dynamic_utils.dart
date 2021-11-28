class DynamicUtils {
  static List<String> createListFromDynamic(List<dynamic> dynamicList) {
    return dynamicList.map((e) => e.toString()).toList();
  }
}
