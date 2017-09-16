//
//  UDImage.swift
//  UDClient
//
//  Created by Omar Albeik on 7/15/17.
//  Copyright © 2017 Udacity. All rights reserved.
//

import Foundation


public class UDImage {
	
	public static let allFields: [UDImageField] = [
		.url,
		.width,
		.height
	]
	
	/// Url to the image
	var url: URL?
	
	/// Width of the image
	var width: Int?
	
	/// Height of the image
	var height: Int?
	
	/// Create a UDImage object.
	///
	/// - Parameter json: json dictionary
	public init(json: [String: Any]) {
		if let urlString = json[UDImageField.url.description] as? String {
			self.url = URL(string: urlString)
		}
		self.width = json[UDImageField.width.description] as? Int
		self.height = json[UDImageField.height.description] as? Int
	}
}


// MARK: - Query
public extension UDImage {
	
		public class func generateQuery(fields: [UDImageField]) -> String {
			guard fields.count > 0 else {
				return ""
			}
			
			let stringFields: [String] = fields.map { $0.description }
			
			let request = Request(name: UDNanodegreeField.heroImage(fields: []).description, fields: stringFields)
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
		return url?.absoluteString ?? "---"
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
