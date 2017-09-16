//
//  UDUser.swift
//  UDClient
//
//  Created by Omar Albeik on 7/14/17.
//  Copyright © 2017 Udacity. All rights reserved.
//

import Foundation


public struct UDUser: Codable {
	
	public static let allKeys: [keys] = [
		.id,
		.firstName,
		.lastName,
		.nickName,
		.imageUrl,
		.email,
		.subscribedNanodegreesCount,
		.graduatedNanodegreesCount,
		.subscribedCoursesCount,
		.graduatedCoursesCount,
		.registrationTime,
		.nanodegrees(keys: UDNanodegree.allKeys)
	]
	
	/// Id of the user
	var id: String?
	
	/// First Name
	var firstName: String?
	
	/// Last Name
	var lastName: String?
	
	/// Nickname
	var nickName: String?
	
	/// A url for the image of the user
	var imageUrl: URL?
	
	/// Email address
	var email: String?
	
	/// Number of nanodegrees the user is enrolled in
	var subscribedNanodegreesCount: Int?
	
	/// Number of nanodegrees the user is graduated from
	var graduatedNanodegreesCount: Int?
	
	/// Subscribed courses count
	var subscribedCoursesCount: Int?
	
	/// Number of courses the user is graduated from
	var graduatedCoursesCount: Int?
	
	/// The earliest membership date of the user
	var registrationTime: Date?
	
	/// User Nanodegrees
	var nanodegrees: [UDNanodegree]?
	
	
	/// Create a UDNanodegree object.
	///
	/// - Parameter json: JSON object
	public init?(json: Data) {
		let decoder = JSONDecoder()
		decoder.dateDecodingStrategy = .formatted(DateFormatter.iso8061)
		guard let user = try? decoder.decode(UDUser.self, from: json) else {
			return nil
		}
		
		self = user
	}
	
	public init(from decoder: Decoder) throws {
		let values = try decoder.container(keyedBy: CodingKeys.self)
		
		id = try? values.decode(String.self, forKey: .id)
		firstName = try? values.decode(String.self, forKey: .firstName)
		lastName = try? values.decode(String.self, forKey: .lastName)
		nickName = try? values.decode(String.self, forKey: .nickName)
		imageUrl = try? values.decode(URL.self, forKey: .imageUrl)
		email = try? values.decode(String.self, forKey: .email)
		subscribedNanodegreesCount = try? values.decode(Int.self, forKey: .subscribedCoursesCount)
		graduatedNanodegreesCount = try? values.decode(Int.self, forKey: .graduatedNanodegreesCount)
		subscribedCoursesCount = try? values.decode(Int.self, forKey: .subscribedCoursesCount)
		graduatedCoursesCount = try? values.decode(Int.self, forKey: .graduatedCoursesCount)
		registrationTime = try? values.decode(Date.self, forKey: .registrationTime)
		nanodegrees = try? values.decode([UDNanodegree].self, forKey: .nanodegrees)
	}
	
}


extension UDUser {
	
	fileprivate enum CodingKeys: String, CodingKey {
		case id = "id"
		case firstName = "first_name"
		case lastName = "last_name"
		case nickName = "nickname"
		case imageUrl = "image_url"
		case email = "email"
		case subscribedNanodegreesCount = "subscribed_nanodegrees_count"
		case graduatedNanodegreesCount = "graduated_nanodegrees_count"
		case subscribedCoursesCount = "subscribed_courses_count"
		case graduatedCoursesCount = "graduated_courses_count"
		case registrationTime = "registration_time"
		case nanodegrees = "nanodegrees"
	}
	
}


public extension UDUser {
	
	public enum keys {
		case id
		case firstName
		case lastName
		case nickName
		case imageUrl
		case email
		case subscribedNanodegreesCount
		case graduatedNanodegreesCount
		case subscribedCoursesCount
		case graduatedCoursesCount
		case registrationTime
		case nanodegrees(keys: [UDNanodegree.keys])
	}
	
}


extension UDUser.keys: CustomStringConvertible {
	
	public var description: String {
		switch self {
		case .id:
			return UDUser.CodingKeys.id.stringValue
		case .firstName:
			return UDUser.CodingKeys.firstName.stringValue
		case .lastName:
			return UDUser.CodingKeys.lastName.stringValue
		case .nickName:
			return UDUser.CodingKeys.nickName.stringValue
		case .imageUrl:
			return UDUser.CodingKeys.imageUrl.stringValue
		case .email:
			return UDUser.CodingKeys.email.stringValue
		case .subscribedNanodegreesCount:
			return UDUser.CodingKeys.subscribedCoursesCount.stringValue
		case .graduatedNanodegreesCount:
			return UDUser.CodingKeys.graduatedCoursesCount.stringValue
		case .subscribedCoursesCount:
			return UDUser.CodingKeys.subscribedCoursesCount.stringValue
		case .graduatedCoursesCount:
			return UDUser.CodingKeys.graduatedCoursesCount.stringValue
		case .registrationTime:
			return UDUser.CodingKeys.registrationTime.stringValue
		case .nanodegrees:
			return UDUser.CodingKeys.nanodegrees.stringValue
		}
	}
}


// MARK: - Query
public extension UDUser {
	
	public static func generateQuery(keys: [keys]) -> String {
		guard keys.count > 0 else {
			return ""
		}
		
		var keysStrings: [String] = []
		
		keys.forEach { key in
			if case .nanodegrees(let ndKeys) = key {
				keysStrings.append(UDNanodegree.generateQuery(keys: ndKeys))
			} else {
				keysStrings.append(key.description)
			}
		}
		
		let request = Request(name: "user", fields: keysStrings)
		let query = "{\"query\":\"\(Query(request: request).create())\"}"
		return query
	}
	
}


// MARK: - Equatable
extension UDUser: Equatable {
	
	public static func ==(lhs: UDUser, rhs: UDUser) -> Bool {
		return lhs.id == rhs.id
	}
	
}


// MARK: - CustomStringConvertible
extension UDUser: CustomStringConvertible {
	
	public var description: String {
		return firstName ?? "---"
	}
	
}


// MARK: - CustomDebugStringConvertible
extension UDUser: CustomDebugStringConvertible {
	
	public var debugDescription: String {
		var string = """
		Id: \(id ?? "--")
		First name: \(firstName ?? "--")
		Last name: \(lastName ?? "--")
		NickName: \(nickName ?? "--")
		Email: \(email ?? "--")
		Image URL: \(imageUrl?.absoluteString ?? "--")
		Registration Time: \(registrationTime?.description ?? "--")
		Subscribed Nanodegrees count: \(subscribedNanodegreesCount?.description ?? "--")
		Graduated nanodegrees count: \(graduatedNanodegreesCount?.description ?? "--")
		Subscribed Courses count: \(subscribedCoursesCount?.description ?? "--")
		Graduated Courses count: \(graduatedCoursesCount?.description ?? "--")
		"""
		
		for nanodegree in nanodegrees ?? [] {
			string += "\n-------------------\n"
			string += nanodegree.debugDescription
		}
		
		return string
	}
	
}
