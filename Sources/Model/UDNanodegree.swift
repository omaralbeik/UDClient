//
//  UDNanodegree.swift
//  UDClient
//
//  Created by Omar Albeik on 7/14/17.
//  Copyright © 2017 Udacity. All rights reserved.
//

import Foundation


public struct UDNanodegree: Codable {
	
	public static let allKeys: [keys] = [
		.key,
		.title,
		.summary,
		.isTermBased,
		.providesCareerServices,
		.dateUpdated,
		.isGraduated,
		.dateUpdated,
		.isReadyForGraduation,
		.heroImage(keys: UDImage.allKeys)
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
	/// - Parameter json: JSON object
	public init?(json: Data) {
		let decoder = JSONDecoder()
		decoder.dateDecodingStrategy = .formatted(DateFormatter.iso8061)
		guard let nanodegree = try? decoder.decode(UDNanodegree.self, from: json) else {
			return nil
		}
		
		self = nanodegree
	}
	
	
	public init(from decoder: Decoder) throws {
		let values = try decoder.container(keyedBy: CodingKeys.self)
		
		key = try? values.decode(String.self, forKey: .key)
		title = try? values.decode(String.self, forKey: .title)
		summary = try? values.decode(String.self, forKey: .summary)
		isTermBased = try? values.decode(Bool.self, forKey: .isTermBased)
		providesCareerServices = try? values.decode(Bool.self, forKey: .providesCareerServices)
		dateUpdated = try? values.decode(Date.self, forKey: .dateUpdated)
		isGraduated = try? values.decode(Bool.self, forKey: .isGraduated)
		dateGraduated = try? values.decode(Date.self, forKey: .dateGraduated)
		isReadyForGraduation = try? values.decode(Bool.self, forKey: .isReadyForGraduation)
		heroImage = try? values.decode(UDImage.self, forKey: .heroImage)
	}
	
}


extension UDNanodegree {

	fileprivate enum CodingKeys: String, CodingKey {
		case key = "key"
		case title = "title"
		case summary = "summary"
		case isTermBased = "is_term_based"
		case providesCareerServices = "provides_career_services"
		case dateUpdated = "updated_at"
		case isGraduated = "is_graduated"
		case dateGraduated = "graduation_date"
		case isReadyForGraduation = "is_ready_for_graduation"
		case heroImage = "hero_image"
	}
	
}


public extension UDNanodegree {
	
	public enum keys {
		case key
		case title
		case summary
		case isTermBased
		case providesCareerServices
		case dateUpdated
		case isGraduated
		case dateGraduated
		case isReadyForGraduation
		case heroImage(keys: [UDImage.keys])
	}
	
}

extension UDNanodegree.keys: CustomStringConvertible {
	
	public var description: String {
		switch self {
		case .key:
			return UDNanodegree.CodingKeys.key.stringValue
		case .title:
			return UDNanodegree.CodingKeys.title.stringValue
		case .summary:
			return UDNanodegree.CodingKeys.summary.stringValue
		case .isTermBased:
			return UDNanodegree.CodingKeys.isTermBased.stringValue
		case .providesCareerServices:
			return UDNanodegree.CodingKeys.providesCareerServices.stringValue
		case .dateUpdated:
			return UDNanodegree.CodingKeys.dateUpdated.stringValue
		case .isGraduated:
			return UDNanodegree.CodingKeys.isGraduated.stringValue
		case .dateGraduated:
			return UDNanodegree.CodingKeys.dateGraduated.stringValue
		case .isReadyForGraduation:
			return UDNanodegree.CodingKeys.isReadyForGraduation.stringValue
		case .heroImage:
			return UDNanodegree.CodingKeys.heroImage.stringValue
		}
	}
}


// MARK: - Query
public extension UDNanodegree {
	
	public static func generateQuery(keys: [keys]) -> String {
		guard keys.count > 0 else {
			return ""
		}
		
		var keysStrings: [String] = []
		
		keys.forEach { key in
			if case .heroImage(let keys) = key {
				keysStrings.append(UDImage.generateQuery(keys: keys))
			} else {
				keysStrings.append(key.description)
			}
		}
		
		let request = Request(name: UDUser.keys.nanodegrees(keys: []).description, fields: keysStrings)
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
