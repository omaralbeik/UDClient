//
//  Request.swift
//  GraphQLicious
//
//  Created by Felix Dietz on 26/05/16.
//  Copyright © 2016 WeltN24. All rights reserved.
//

/// A Request with a customized textual representation suitable for GraphQL.
struct Request: Field, CustomDebugStringConvertible {
	/// The alias of `self`
	let alias: String
	
	/// The name of `self`
	let name: String
	
	/// The arguments of `self`
	let arguments: [GraphQLConvertible]
	
	/// The fields of `self`
	let fields: [Field]
	
	init(withAlias alias: String = "", name: String, arguments: [Argument] = [], fields: [Field] = []) {
		self.alias = alias.withoutWhiteSpaces
		self.name = name.withoutWhiteSpaces
		self.arguments = arguments.map{$0}
		self.fields = fields
	}
	
	var asGraphQLString: String {
		return [
			getAliasString(),
			name,
			getArgumentsString(),
			getFieldsString()
			].joined(separator: "")
	}
	
	private func getAliasString() -> String {
		return alias == "" ? "" : "\(alias):"
	}
	
	private func getArgumentsString() -> String {
		guard arguments.count > 0 else {
			return ""
		}
		return "(\(arguments.map {$0.asGraphQLString}.joined(separator: ",")))"
	}
	
	private func getFieldsString() -> String {
		guard fields.count > 0 else {
			return ""
		}
		
		return "{\(fields.map {$0.asGraphQLField}.joined(separator: ","))}"
	}
	
	var debugDescription: String {
		return [
			getAliasString(),
			name,
			getArgumentsString(),
			getFieldsDebugString()
			].joined(separator: " ")
	}
	
	private func getFieldsDebugString() -> String {
		guard fields.count > 0 else {
			return ""
		}
		
		return "{\n\t\t\(fields.map{$0.asGraphQLField}.joined(separator: ",\n\t\t"))\n\t}"
	}
}
