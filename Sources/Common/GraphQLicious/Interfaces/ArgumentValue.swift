//
//  ArgumentValue.swift
//  GraphQLicious
//
//  Created by Felix Dietz on 07/04/16.
//  Copyright © 2016 WeltN24. All rights reserved.
//

///Argument value that can be read by GraphQL
protocol ArgumentValue: GraphQLConvertible {
  /// A GraphQL Argument representation of `self`.
  var asGraphQLArgument: String { get }
}

extension ArgumentValue {
  var asGraphQLString: String {
    return self.asGraphQLArgument
  }
}

extension String: ArgumentValue {
  var asGraphQLArgument: String {
    return self.withQuotes
  }
}

extension Int: ArgumentValue {
  var asGraphQLArgument: String {
    return asGraphQLString
  }
}

extension Float: ArgumentValue {
  var asGraphQLArgument: String {
    return asGraphQLString
  }
}

extension Double: ArgumentValue {
  var asGraphQLArgument: String {
    return asGraphQLString
  }
}

extension Bool: ArgumentValue {
  var asGraphQLArgument: String {
    return asGraphQLString
  }
}
