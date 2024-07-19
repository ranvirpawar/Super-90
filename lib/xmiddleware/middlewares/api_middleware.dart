import 'package:flutter/foundation.dart';

class APIMiddleware<T, K> {
  List<T> convertAsPerModal(var response, List<Function> fromJson,
      List<Map<String, Type>> expectedTypes) {
// Check if response is a Map
    if (response is Map) {
      return List<T>.generate(
          1, (index) => singleObject(response, expectedTypes, fromJson));
    } else if (response is List) {
// If the response is a list, iterate over each item in the list
      List<T> convertedList = [];
      for (var item in response) {
        if (item is Map) {
// If the item is a map, convert it as per the modal
          List<T> convertedItem =
              convertAsPerModal(item, fromJson, expectedTypes);
          convertedList.addAll(convertedItem);
        } else {
          convertedList.add(item);
        }
      }
      return convertedList;
    }
// If response is not a Map or a List then return an empty map
    return [];
  }

  List<K> convertAsPerModalObject(var response, List<Function> fromJson,
      List<Map<String, Type>> expectedTypes) {
// Check if response is a Map
    //var oldRoot = newObject;
    // print(response);
    if (response is Map) {
      //print("d:$response");
// Check if the map is empty
      return List<K>.generate(
          1, (index) => singleObject1(response, expectedTypes, fromJson));
    } else if (response is List) {
// If the response is a list, iterate over each item in the list
      List<K> convertedList = [];
      for (var item in response) {
        if (item is Map) {
// If the item is a map, convert it as per the modal
          List<K> convertedItem =
              convertAsPerModalObject(item, fromJson, expectedTypes);
          convertedList.addAll(convertedItem);
        } else {
// If the item is not a map, add it to the list as is
          convertedList.add(item);
        }
      }
      return convertedList;
    }
// If response is not a Map or a List then return an empty map
    return [];
  }

  var newObject = 0;
  T singleObject(var response, List<Map<String, Type>> expectedTypes,
      List<Function> fromJson) {
    if (response.isEmpty) {
      return fromJson.first({});
    }

    Map<String, dynamic> convertedResponse = {};
// Iterate over the map and check each field
    for (var key in response.keys) {
      var value = response[key];
      //  print(key);
      // print('key=$key,value=$value
// Check the daanta type of the value
      if (expectedTypes[0].containsKey(key)) {
        if (value.runtimeType != expectedTypes[0][key] ||
            value.runtimeType == List ||
            value.runtimeType == Map) {
// If the value is not of the expected type, try to convert it
          if (expectedTypes[0][key] == int) {
            convertedResponse[key] = int.tryParse(value.toString()) ?? 0;
          } else if (expectedTypes[0][key] == double) {
            convertedResponse[key] = double.tryParse(value.toString()) ?? 0.0;
          } else if (expectedTypes[0][key] == String) {
            convertedResponse[key] = value.toString();
          } else if (expectedTypes[0][key] == bool) {
            convertedResponse[key] = bool.fromEnvironment(
                value.toString().toLowerCase(),
                defaultValue: false);
          } else if (expectedTypes[0][key] == List) {
            List<K> convertedList = [];
            // newObject = newObject + 1;
            //  print("In List=$newObject,$key");
            for (var item in value) {
              if (item is Map) {
                List<K> convertedItem =
                    convertAsPerModalObject(item, fromJson, expectedTypes);
                convertedList.addAll(convertedItem);
              } else {
                convertedList.add(item);
              }
            }

            convertedResponse[key] = convertedList;
          } else if (expectedTypes[0][key] == Map) {
            List<K> convertedList = [];
            // newObject = newObject + 1;
//print("inMap");
            List<K> convertedItem =
                convertAsPerModalObject(value as Map, fromJson, expectedTypes);
            //  print("convertedItem=$convertedItem");
            convertedList.addAll(convertedItem);
            convertedResponse[key] = convertedList.first;
          }
        } else {
          convertedResponse[key] = value;
        }
      }
    }
    //  print("finalString=$convertedResponse");
// If all fields are valid, convert the response to a TestModal
    return fromJson.first(convertedResponse);
  }

  singleObject1(var response, List<Map<String, Type>> expectedTypes,
      List<Function> fromJson) {
//   print(newObject);
    // newObject = newObject + 1;
    Map<String, dynamic> convertedResponse = {};
// Iterate over the map and check each field
    for (var key in response.keys) {
      var value = response[key];
      if (key == "country") {
        if (kDebugMode) {
          print("$newObject,${expectedTypes[newObject]}");
        }
      }
      // print(key);
// Check the data type of the value
      if (expectedTypes[newObject].containsKey(key)) {
        if (value.runtimeType != expectedTypes[newObject][key] ||
            value.runtimeType == List) {
          if (expectedTypes[newObject][key] == int) {
            convertedResponse[key] = int.tryParse(value.toString());
          } else if (expectedTypes[newObject][key] == double) {
            convertedResponse[key] = double.tryParse(value.toString());
          } else if (expectedTypes[newObject][key] == String) {
            convertedResponse[key] = value.toString();
          } else if (expectedTypes[newObject][key] == List) {
            List convertedList = [];
            //newObject = newObject + 1;
            for (var item in value) {
              if (item is Map) {
                List convertedItem =
                    convertAsPerModalObject(item, fromJson, expectedTypes);
                convertedList.addAll(convertedItem);
              } else {
                convertedList.add(item);
              }
            }
            convertedResponse[key] = convertedList;
            //  newObject = newObject - 1;
          } else if (expectedTypes[newObject][key] == Map) {
            List<K> convertedList = [];
            print("map=$value");
            newObject = newObject + 1;
            print("map=$newObject");
            List<K> convertedItem =
                convertAsPerModalObject(value as Map, fromJson, expectedTypes);
            convertedList.addAll(convertedItem);
            convertedResponse[key] = convertedList.first;
          }
        } else {
          convertedResponse[key] = value;
        }
      }
    }
    // print("1=$convertedResponse");
    return convertedResponse;
// If all fields are valid, convert the response to a TestModal
    //return fromJson[1](convertedResponse);
  }

//
//   singleObject2(
//       var response, Map<String, Type> expectedTypes, Function fromJson) {
//     if (response.isEmpty) {
//       return fromJson({});
//     }
//    dynamic convertedResponse = {};
// // Iterate over the map and check each field
//     for (var key in response.keys) {
//       var value = response[key];
//
// // Check the data type of the value
//       if (expectedTypes.containsKey(key)) {
//         if (value.runtimeType != expectedTypes[key]) {
//           if (expectedTypes[key] == int) {
//             convertedResponse[key] = int.tryParse(value.toString()) ?? 0;
//           } else if (expectedTypes[key] == double) {
//             convertedResponse[key] = double.tryParse(value.toString()) ?? 0.0;
//           } else if (expectedTypes[key] == String) {
//             convertedResponse[key] = value.toString();
//           } else if (expectedTypes[key] == List) {
//
//           }
//         } else {
//           convertedResponse[key] = value;
//         }
//       }
//     }
// // If all fields are valid, convert the response to a TestModal
//     return convertedResponse;
//   }

//
//   List convertAsPerModalObjectExpense(
//       var response, Function fromJson, Map<String, Type> expectedTypes) {
// // Check if response is a Map
//     if (response is Map) {
// // Check if the map is empty
//       return List.generate(
//           1, (index) => singleObject2(response, expectedTypes, fromJson));
//     } else if (response is List) {
//       newObject = newObject  +1;
// // If the response is a list, iterate over each item in the list
//       List convertedList = [];
//       for (var item in response) {
//         if (item is Map) {
// // If the item is a map, convert it as per the modal
//           List convertedItem =
//           convertAsPerModalObjectExpense(item, fromJson, expectedTypes);
//           convertedList.addAll(convertedItem);
//         } else {
// // If the item is not a map, add it to the list as is
//           convertedList.add(item);
//         }
//       }
//       return convertedList;
//     }
// // If response is not a Map or a List then return an empty map
//     return [];
//   }
}