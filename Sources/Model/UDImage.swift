//
//  UDImage.swift
//  UDClient
//
//  Created by Omar Albeik on 7/15/17.
//  Copyright © 2017 Udacity. All rights reserved.
//

import Foundation


public struct UDImage: Codable {
	
	/// Url to the image
	public var url: URL?
	
	/// Width of the image
	public var width: Int?
	
	/// Height of the image
	public var height: Int?
	
	/// Create a UDImage object.
	///
	/// - Parameter json: JSON object
	public init?(json: Data) {
		let decoder = JSONDecoder()
		guard let image = try? decoder.decode(UDImage.self, from: json) else {
			return nil
		}
		
		self = image
	}
}


// MARK: - Fields
public extension UDImage {
	
	public enum fields {
		case url
		case width
		case height
	}
	
	public static var allFields: [UDImage.fields] {
		return [
			.url,
			.width,
			.height
		]
	}
	
	fileprivate enum CodingKeys: String, CodingKey {
		case url = "url"
		case width = "width"
		case height = "height"
	}
	
}


// MARK: - Fields: CustomStringConvertible
extension UDImage.fields: CustomStringConvertible {
	
	public var description: String {
		switch self {
		case .url:
			return UDImage.CodingKeys.url.stringValue
		case .width:
			return UDImage.CodingKeys.width.stringValue
		case .height:
			return UDImage.CodingKeys.height.stringValue
		}
	}
}




// MARK: - Query
public extension UDImage {
	
	public static func generateQuery(fields: [UDImage.fields]) -> String {
		guard fields.count > 0 else {
			return ""
		}
		
		let fieldsStrings: [String] = fields.map { $0.description }
		
		let request = Request(name: UDNanodegree.fields.heroImage(fields: []).description, fields: fieldsStrings)
		return request.asGraphQLString
	}
	
}


// MARK: - Equatable
extension UDImage: Equatable {
	
	public static func ==(lhs: UDImage, rhs: UDImage) -> Bool {
		return lhs.url == rhs.url
	}
	
}


// MARK: - CustomStringConvertible
extension UDImage: CustomStringConvertible {
	
	public var description: String {
		return url?.absoluteString ?? "--"
	}
	
}


// MARK: - CustomDebugStringConvertible
extension UDImage: CustomDebugStringConvertible {
	
	public var debugDescription: String {
		return """
		
		Url: \(url?.absoluteString ?? "--")
		Width: \(width?.description ?? "--")
		Height: \(height?.description ?? "--")
		
		"""
	}
	
}
