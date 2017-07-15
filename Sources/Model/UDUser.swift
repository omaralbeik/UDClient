//
//  UDUser.swift
//  UDClient
//
//  Created by Omar Albeik on 7/14/17.
//  Copyright © 2017 Udacity. All rights reserved.
//

import ObjectMapper
import GraphQLicious
import SwifterSwift


public class UDUser: Mappable {
	
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
	
	
	public func mapping(map: Map) {
		id <- map[UDUserField.id.mapperField]
		firstName <- map[UDUserField.firstName.mapperField]
		lastName <- map[UDUserField.lastName.mapperField]
		nickname <- map[UDUserField.nickName.mapperField]
		imageUrl <- (map[UDUserField.imageUrl.mapperField], URLTransform())
		email <- map[UDUserField.email.mapperField]
		subscribedNanodegreesCount <- map[UDUserField.subscribedNanodegreesCount.mapperField]
		graduatedNanodegreesCount <- map[UDUserField.graduatedNanodegreesCount.mapperField]
		subscribedCoursesCount <- map[UDUserField.subscribedCoursesCount.mapperField]
		graduatedCoursesCount <- map[UDUserField.graduatedCoursesCount.mapperField]
		registrationTime <- (map[UDUserField.registrationTime.mapperField], ISO8601ExtendedDateTransform())
		nanodegrees <- map[UDUserField.nanodegrees(fields: []).mapperField]
	}
	
	required public init?(map: Map) { }
	
}


internal extension UDUser {
	
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


extension UDUser: Equatable {
	
	public static func ==(lhs: UDUser, rhs: UDUser) -> Bool {
		return lhs.id == rhs.id
	}
	
}


extension UDUser: CustomStringConvertible {
	
	public var description: String {
		return toJSONString(prettyPrint: true) ?? firstName ?? "-"
	}
	
}


extension UDUser: CustomDebugStringConvertible {
	
	public var debugDescription: String {

		var string = ""

		if let id = self.id {
			string += "Id: \(id)\n"
		}
		
		if let firstName = self.firstName {
			string += "First name: \(firstName)\n"
		}
		
		if let lastName = self.lastName {
			string += "Last name: \(lastName)\n"
		}
		
		if let nickname = self.nickname {
			string += "Nickname: \(nickname)\n"
		}
		
		if let email = self.email {
			string += "Email: \(email)\n"
		}
		
		if let imageUrl = self.imageUrl {
			string += "Image URL: \(imageUrl)\n"
		}
		
		if let registrationTime = self.registrationTime {
			string += "Registration Time: \(registrationTime.dateTimeString())\n"
		}
		

		if let subscribedNanodegreesCount = self.subscribedNanodegreesCount {
			string += "Subscribed Nanodegrees count: \(subscribedNanodegreesCount)\n"
		}
		
		if let graduatedNanodegreesCount = self.graduatedNanodegreesCount {
			string += "Graduated nanodegrees count: \(graduatedNanodegreesCount)\n"
		}
		
		if let subscribedCoursesCount = self.subscribedCoursesCount {
			string += "Subscribed Courses count: \(subscribedCoursesCount)\n"
		}
		
		if let graduatedCoursesCount = self.graduatedCoursesCount {
			string += "Graduated Courses count: \(graduatedCoursesCount)\n"
		}
		
		for nanodegree in nanodegrees ?? [] {
			string += "-------------------\n"
			string += nanodegree.debugDescription
		}
		
		return string
		
	}
	
}
