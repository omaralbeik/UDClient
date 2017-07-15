//
//  UDImage.swift
//  UDClientTests
//
//  Created by Omar Albeik on 7/15/17.
//  Copyright © 2017 Udacity. All rights reserved.
//

import ObjectMapper
import GraphQLicious


public class UDImage: Mappable {
	
	/// Url to the image
	var url: URL?
	
	/// Width of the image
	var width: Int?
	
	/// Height of the image
	var height: Int?
	
	public func mapping(map: Map) {
		url <- (map[UDImageField.url.description], URLTransform())
		width <- map[UDImageField.width.description]
		height <- map[UDImageField.height.description]
	}
	
	public required init?(map: Map) { }
	
}


extension UDImage {
	
	internal class func generateQuery(fields: [UDImageField]) -> String {
		guard fields.count > 0 else {
			return ""
		}
		
		let stringFields: [String] = fields.map { $0.description }
		
		let request = Request(name: "hero_image", fields: stringFields)
		return request.asGraphQLString
	}
	
}


extension UDImage: Equatable {
	
	public static func ==(lhs: UDImage, rhs: UDImage) -> Bool {
		return lhs.url == rhs.url
	}
	
}


extension UDImage: CustomStringConvertible {
	
	public var description: String {
		return toJSONString(prettyPrint: true) ?? url?.absoluteString ?? "-"
	}
	
}


extension UDImage: CustomDebugStringConvertible {
	
	public var debugDescription: String {
		
		var string = ""
		
		if let url = self.url {
			string += "Url: \(url.absoluteString)\n"
		}
		
		if let width = self.width {
			string += "Width: \(width)\n"
		}
		
		if let height = self.height {
			string += "Height: \(height)\n"
		}
		
		return string
		
	}
	
}
