//
//  UDUserField.swift
//  UDClientTests
//
//  Created by Omar Albeik on 7/14/17.
//  Copyright © 2017 Udacity. All rights reserved.
//

import Foundation


public enum UDUserField {
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
	case nanodegrees(fields: [UDNanodegreeField])
}


extension UDUserField: CustomStringConvertible {
	
	public var description: String {
		switch self {
		case .id:
			return "id"
		case .firstName:
			return "first_name"
		case .lastName:
			return "last_name"
		case .nickName:
			return "nickname"
		case .imageUrl:
			return "image_url"
		case .email:
			return "email"
		case .subscribedNanodegreesCount:
			return "subscribed_nanodegrees_count"
		case .graduatedNanodegreesCount:
			return "graduated_nanodegrees_count"
		case .subscribedCoursesCount:
			return "subscribed_courses_count"
		case .graduatedCoursesCount:
			return "graduated_courses_count"
		case .registrationTime:
			return "registration_time"
		case .nanodegrees:
			return "nanodegrees"
		}
	}
	
}


extension UDUserField {
	
	internal var mapperField: String {
		return "data.user.\(description)"
	}
	
}
