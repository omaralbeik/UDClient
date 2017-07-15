//
//  UDNanodegree.swift
//  UDClient
//
//  Created by Omar Albeik on 7/14/17.
//  Copyright © 2017 Udacity. All rights reserved.
//

import ObjectMapper
import GraphQLicious
import SwifterSwift


public class UDNanodegree: Mappable {
	
	/// Key of the Nanodegree
	var key: String?
	
	/// Title of the Nanodegree
	var title: String?
	
	/// Short summary of this Root Node
	var summary: String?
	
	/// Counts for students in various states of enrollment
	var enrollmentCounts: Int?
	
	/// Whether or not this Nanodegree is using the term-based UI and payment system
	var isTermBased: Bool?
	
	/// Whether or not this Nanodegree provides career services
	var providesCareerServices: Date?
	
	/// The last time the Nanodegree was updated
	var dateUpdated: Date?
	
	/// Whether or not the given user has graduated from the node
	var isGraduated: Bool?
	
	/// Date when the user graduated from the node
	var dateGraduated: Date?
	
	/// Whether or not the given user has finished the required projects of the nanodegree
	var isReadyForGraduation: Bool?
	
	/// Hero Image at the top of the Nanodegree Page, required 1200x900px
	var heroImage: UDImage?
	
	
	public func mapping(map: Map) {
		key <- map[UDNanodegreeField.key.description]
		title <- map[UDNanodegreeField.title.description]
		summary <- map[UDNanodegreeField.summary.description]
		isTermBased <- map[UDNanodegreeField.isTermBased.description]
		providesCareerServices <- map[UDNanodegreeField.providesCareerServices.description]
		dateUpdated <- (map[UDNanodegreeField.dateUpdated.description], ISO8601ExtendedDateTransform())
		isGraduated <- map[UDNanodegreeField.isGraduated.description]
		dateGraduated <- (map[UDNanodegreeField.dateGraduated.description], ISO8601ExtendedDateTransform())
		isReadyForGraduation <- map[UDNanodegreeField.isReadyForGraduation.description]
		heroImage <- map[UDNanodegreeField.heroImage(fields: []).description]
	}
	
	public required init?(map: Map) { }
	
}


extension UDNanodegree {
	
	internal class func generateQuery(fields: [UDNanodegreeField]) -> String {
		guard fields.count > 0 else {
			return ""
		}
		
		var fieldsStrings: [String] = []
		
		fields.forEach { field in
			if case UDNanodegreeField.heroImage(let imageFields) = field {
				fieldsStrings.append(UDImage.generateQuery(fields: imageFields))
			} else {
				fieldsStrings.append(field.description)
			}
		}

		let request = Request(name: "nanodegrees", fields: fieldsStrings)
		return request.asGraphQLString
	}
	
}


extension UDNanodegree: Equatable {
	
	public static func ==(lhs: UDNanodegree, rhs: UDNanodegree) -> Bool {
		return lhs.key == rhs.key
	}
	
}

extension UDNanodegree: CustomStringConvertible {
	
	public var description: String {
		return toJSONString(prettyPrint: true) ?? title ?? "-"
	}
	
}


extension UDNanodegree: CustomDebugStringConvertible {
	
	public var debugDescription: String {
		
		var string = ""
		
		if let key = self.key {
			string += "Key: \(key)\n"
		}
		
		if let title = self.title {
			string += "Title: \(title)\n"
		}
		
		if let summary = self.summary {
			string += "Summary: \(summary)\n"
		}
		
		if let isTermBased = self.isTermBased {
			string += "Is term based: \(isTermBased)\n"
		}
		
		if let providesCareerServices = self.providesCareerServices {
			string += "Provides career services: \(providesCareerServices)\n"
		}
		
		if let dateUpdated = self.dateUpdated {
			string += "Date Updated: \(dateUpdated.dateTimeString())\n"
		}
		
		if let isGraduated = self.isGraduated {
			string += "Is graduated: \(isGraduated)\n"
		}
		
		if let dateGraduated = self.dateGraduated {
			string += "Date graduated: \(dateGraduated)\n"
		}
		
		if let isReadyForGraduation = self.isReadyForGraduation {
			string += "Is ready for graduation: \(isReadyForGraduation)\n"
		}
		
		if let heroImage = self.heroImage {
			string += "Hero Image:\n"
			if let url = heroImage.url {
				string += "Url: \(url.absoluteString)\n"
			}
			if let width = heroImage.width {
				string += "Width: \(width)\n"
			}
			if let height = heroImage.height {
				string += "Height: \(height)\n"
			}
		}
		
		return string
	}
	
}


