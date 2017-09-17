//
//  UDUser.swift
//  UDClient
//
//  Created by Omar Albeik on 7/14/17.
//  Copyright © 2017 Udacity. All rights reserved.
//

import Foundation


public struct UDUser: Codable {
	
	/// Id of the user
	public var id: String?
	
	/// First Name
	public var firstName: String?
	
	/// Last Name
	public var lastName: String?
	
	/// Nickname
	public var nickName: String?
	
	/// A url for the image of the user
	public var imageUrl: URL?
	
	/// Email address
	public var email: String?
	
	/// Number of nanodegrees the user is enrolled in
	public var subscribedNanodegreesCount: Int?
	
	/// Number of nanodegrees the user is graduated from
	public var graduatedNanodegreesCount: Int?
	
	/// Subscribed courses count
	public var subscribedCoursesCount: Int?
	
	/// Number of courses the user is graduated from
	public var graduatedCoursesCount: Int?
	
	/// The earliest membership date of the user
	public var registrationTime: Date?
	
	/// User Nanodegrees
	public var nanodegrees: [UDNanodegree]?
	
	
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
		subscribedNanodegreesCount = try? values.decode(Int.self, forKey: .subscribedNanodegreesCount)
		graduatedNanodegreesCount = try? values.decode(Int.self, forKey: .graduatedNanodegreesCount)
		subscribedCoursesCount = try? values.decode(Int.self, forKey: .subscribedCoursesCount)
		graduatedCoursesCount = try? values.decode(Int.self, forKey: .graduatedCoursesCount)
		registrationTime = try? values.decode(Date.self, forKey: .registrationTime)
		nanodegrees = try? values.decode([UDNanodegree].self, forKey: .nanodegrees)
	}
	
}


// MARK: - Fields
extension UDUser {
	
	public enum fields {
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
		case nanodegrees(fields: [UDNanodegree.fields])
	}
	
	public static var allFields: [UDUser.fields] {
		return [
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
			.nanodegrees(fields: UDNanodegree.allFields)
		]
	}
	
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



// MARK: - Fields: CustomStringConvertible
extension UDUser.fields: CustomStringConvertible {
	
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
			return UDUser.CodingKeys.subscribedNanodegreesCount.stringValue
		case .graduatedNanodegreesCount:
			return UDUser.CodingKeys.graduatedNanodegreesCount.stringValue
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
	
	public static func generateQuery(fields: [UDUser.fields]) -> String {
		guard fields.count > 0 else {
			return ""
		}
		
		var fieldsStrings: [String] = []
		
		fields.forEach { field in
			if case .nanodegrees(let ndFields) = field {
				fieldsStrings.append(UDNanodegree.generateQuery(fields: ndFields))
			} else {
				fieldsStrings.append(field.description)
			}
		}
		
		let request = Request(name: "user", fields: fieldsStrings)
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
		return firstName ?? "--"
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
			string += """
			
			------
			\(nanodegree.debugDescription)
			
			"""
		}
		
		return string
	}
	
}
