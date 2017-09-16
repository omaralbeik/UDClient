//
//  UDUser.swift
//  UDClient
//
//  Created by Omar Albeik on 7/14/17.
//  Copyright © 2017 Udacity. All rights reserved.
//

import Foundation


public class UDUser {
	
	public static let allFields: [UDUserField] = [
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
	
	/// Id of the user
	var id: String?
	
	/// First Name
	var firstName: String?
	
	/// Last Name
	var lastName: String?
	
	/// Nickname
	var nickname: String?
	
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
	
	/// Create a UDUser object.
	///
	/// - Parameter json: json dictionary
	public init(json: [String: Any]) {
		self.id =	json[UDUserField.id.description] as? String
		self.firstName = json[UDUserField.firstName.description] as? String
		self.lastName = json[UDUserField.lastName.description] as? String
		self.nickname = json[UDUserField.nickName.description] as? String
		
		if let imageUrlString = json[UDUserField.imageUrl.description] as? String {
			self.imageUrl = URL(string: imageUrlString)
		}
		
		self.email = json[UDUserField.email.description] as? String
		self.subscribedNanodegreesCount = json[UDUserField.subscribedNanodegreesCount.description] as? Int
		self.graduatedNanodegreesCount = json[UDUserField.graduatedNanodegreesCount.description] as? Int
		self.subscribedCoursesCount = json[UDUserField.subscribedCoursesCount.description] as? Int
		self.graduatedCoursesCount = json[UDUserField.graduatedCoursesCount.description] as? Int
		
		if let registrationTimeString = json[UDUserField.registrationTime.description] as? String {
			self.registrationTime = Date(ISO8601string: registrationTimeString)
		}
		
		if let nanodegreesJson = json[UDUserField.nanodegrees(fields: []).description] as? [[String: Any]] {
			self.nanodegrees = nanodegreesJson.map({ UDNanodegree(json: $0) })
		}		
	}
	
}


// MARK: - Query
public extension UDUser {
	
		class func generateQuery(fields: [UDUserField]) -> String {
			guard fields.count > 0 else {
				return ""
			}
	
			var fieldsStrings: [String] = []
	
			fields.forEach { field in
				if case UDUserField.nanodegrees(let ndFields) = field {
					fieldsStrings.append(UDNanodegree.generateQuery(fields: ndFields))
				} else {
					fieldsStrings.append(field.description)
				}
			}
	
			let request = Request(name: "user", fields: fieldsStrings)
			let query = "{\"query\":\"\(Query(request: request).create())\"}"
			print(query)
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
		Nickname: \(nickname ?? "--")
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
