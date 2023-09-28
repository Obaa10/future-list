
dynamic getValueFromJson(dynamic jsonObject, List<String> propertyPath) {
  dynamic value = jsonObject;

  for (var property in propertyPath) {
    if (value is Map && value.containsKey(property)) {
      value = value[property];
    } else {
      return null;
    }
  }

  return value;
}

enum HttpMethod { get, post, getWithBody }
