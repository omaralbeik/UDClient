//
//  Argument.swift
//  GraphQLicious
//
//  Created by Felix Dietz on 31/03/16.
//  Copyright © 2016 WeltN24. All rights reserved.
//

struct Argument {
  /// The key of `self`.
  let key: String
  
  /// The values of `self`.
  let values: [ArgumentValue]
 
  init(key: String, value: ArgumentValue) {
    self.init(key: key, values: [value])
  }
  
  init(key: String, values: [ArgumentValue]) {
    self.key = key
    self.values = values
  }
}

extension Argument: GraphQLConvertible {
  var asGraphQLString: String {
    guard key != "" else {
      return ""
    }
    switch values.count {
    case 0:
      return ""
    case 1:
      return "\(key): \(values[0].asGraphQLArgument)"
    default:
      let valuesString = self.values.map { value in
        value.asGraphQLArgument
        }.joined(separator: ",")
      return "\(key): [\(valuesString)]"
    }
  }
}
