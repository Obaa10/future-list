/// Gets the value of a nested property from a JSON object.

///

/// Args:
/// * jsonObject: The JSON object to get the value from.
/// * propertyPath: A list of strings representing the path to the nested property.
///

/// Returns:
/// The value of the nested property, or `null` if the property does not exist.

///

/// Example:

/// ```dart
/// var jsonObject = {
///   "name": "John Doe",
///   "address": {
///     "street": "123 Main Street",
///     "city": "Anytown",
///     "state": "CA",
///     "zip": "91234"
///   }
/// };

/// var street = getValueFromJson(jsonObject, ["address", "street"]);
/// print(street); // Outputs: 123 Main Street
/// ```
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

/// An enum representing the different HTTP methods.
enum HttpMethod { get, post, getWithBody }
