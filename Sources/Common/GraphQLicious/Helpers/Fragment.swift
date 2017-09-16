//
//  Fragment.swift
//  GraphQLicious
//
//  Created by Felix Dietz on 07/04/16.
//  Copyright © 2016 WeltN24. All rights reserved.
//

struct Fragment {
	let alias: String
	let name: String
	let fields: [Field]
	
	init(withAlias alias: String, name: String, fields: [Field]) {
		self.alias = alias.withoutWhiteSpaces
		self.name = name.withoutWhiteSpaces
		self.fields = fields
	}
}

extension Fragment: Field {
	var asGraphQLField: String {
		return "...\(alias)"
	}
	
	var asGraphQLString: String {
		return [
			"fragment",
			alias,
			"on",
			name,
			getFieldsString()].joined(separator: " ")
	}
	
	private func getFieldsString() -> String {
		guard fields.count > 0 else {
			return ""
		}
		// TODO: Check for fix in Xcode 7.3
		return "{\(fields.map{$0.asGraphQLField}.joined(separator: ","))}"
	}
}

extension Fragment: CustomDebugStringConvertible {
	var debugDescription: String {
		return [
			"fragment",
			alias,
			"on",
			name,
			getFieldsDebugString()].joined(separator: " ")
	}
	
	private func getFieldsDebugString() -> String {
		guard fields.count > 0 else {
			return ""
		}
		// TODO: Check for fix in Xcode 7.3
		let fieldArray: [String] = fields.map{ field in
			if field is Fragment {
				return field.asGraphQLField
			}
			return field.debugDescription
		}
		return "{\n\t\(fieldArray.joined(separator: "\n\t"))\n}\n"
	}
}
