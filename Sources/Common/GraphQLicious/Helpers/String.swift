//
//  String.swift
//  GraphQLicious
//
//  Created by Felix Dietz on 07/04/16.
//  Copyright © 2016 WeltN24. All rights reserved.
//

extension String {
  /// Representation of `self` with surrounding quotes
  var withQuotes: String {
    return "\"\(self)\""
  }
  /// Representation of `self` without any quotes
  var withoutQuotes: String {
		return self.replacingOccurrences(of: "\"", with: "")
  }
  
  /// Representation of `self` without any white spaces
  var withoutWhiteSpaces: String {
		return self.replacingOccurrences(of: " ", with: "")
  }
}
