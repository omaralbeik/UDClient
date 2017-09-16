//
//  UDNanodegree.swift
//  UDClient
//
//  Created by Omar Albeik on 7/14/17.
//  Copyright © 2017 Udacity. All rights reserved.
//

import Foundation


public class UDNanodegree {
	
	public static let allFields: [UDNanodegreeField] = [
		.key,
		.title,
		.summary,
		.isTermBased,
		.providesCareerServices,
		.dateUpdated,
		.isGraduated,
		.dateUpdated,
		.isReadyForGraduation,
		.heroImage(fields: UDImage.allFields)
	]
	
	/// Key of the Nanodegree
	var key: String?
	
	/// Title of the Nanodegree
	var title: String?
	
	/// Short summary of this Root Node
	var summary: String?
	
	/// Whether or not this Nanodegree is using the term-based UI and payment system
	var isTermBased: Bool?
	
	/// Whether or not this Nanodegree provides career services
	var providesCareerServices: Bool?
	
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
	
	/// Create a UDNanodegree object.
	///
	/// - Parameter json: json dictionary
	public init(json: [String: Any]) {
		self.key =	json[UDNanodegreeField.key.description] as? String
		self.title =	json[UDNanodegreeField.title.description] as? String
		self.summary =	json[UDNanodegreeField.summary.description] as? String
		self.isTermBased =	json[UDNanodegreeField.isTermBased.description] as? Bool
		self.providesCareerServices =	json[UDNanodegreeField.providesCareerServices.description] as? Bool
		
		if let dateUpdatedString = json[UDNanodegreeField.dateUpdated.description] as? String {
			self.dateUpdated = Date(ISO8601string: dateUpdatedString)
		}
		
		self.isGraduated =	json[UDNanodegreeField.isGraduated.description] as? Bool
		
		if let dateGraduatedString = json[UDNanodegreeField.dateGraduated.description] as? String {
			self.dateGraduated = Date(ISO8601string: dateGraduatedString)
		}
		
		self.isReadyForGraduation =	json[UDNanodegreeField.isReadyForGraduation.description] as? Bool
	}
	
}


// MARK: - Query
public extension UDNanodegree {
	
		public class func generateQuery(fields: [UDNanodegreeField]) -> String {
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
	
			let request = Request(name: UDUserField.nanodegrees(fields: []).description, fields: fieldsStrings)
			return request.asGraphQLString
		}
	
}


// MARK: - Equatable
extension UDNanodegree: Equatable {
	
	public static func ==(lhs: UDNanodegree, rhs: UDNanodegree) -> Bool {
		return lhs.key == rhs.key
	}
	
}


// MARK: - CustomStringConvertible
extension UDNanodegree: CustomStringConvertible {
	
	public var description: String {
		return title ?? "---"
	}
	
}


// MARK: - CustomDebugStringConvertible
extension UDNanodegree: CustomDebugStringConvertible {
	
	public var debugDescription: String {
		var string = """
		Key: \(key ?? "--")
		Title: \(title ?? "--")
		Summary: \(summary ?? "--")
		Is term based: \(isTermBased?.description ?? "--")
		Provides career services: \(providesCareerServices?.description ?? "--")
		Date Updated: \(dateUpdated?.description ?? "--")
		Is graduated: \(isGraduated?.description ?? "--")
		Date graduated: \(dateGraduated?.description ?? "--")
		Is ready for graduation: \(isReadyForGraduation?.description ?? "--")
		"""
		
		if let image = self.heroImage {
			string += """
			Hero Image:
			"Url: \(image.url?.absoluteString ?? "--")
			"Width: \(image.width?.description ?? "--")
			"Height: \(image.height?.description ?? "--")
			"""
		} else {
			string += """
			
			Hero Image: ---
			
			"""
		}
		
		return string
	}
	
}
