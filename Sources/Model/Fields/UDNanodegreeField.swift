//
//  UDNanodegreeField.swift
//  UDClient
//
//  Created by Omar Albeik on 7/14/17.
//  Copyright © 2017 Udacity. All rights reserved.
//

import Foundation


public enum UDNanodegreeField {
	case key
	case title
	case summary
	case isTermBased
	case providesCareerServices
	case dateUpdated
	case isGraduated
	case dateGraduated
	case isReadyForGraduation
	case heroImage(fields: [UDImageField])
}

extension UDNanodegreeField: CustomStringConvertible {
	
	public var description: String {
		switch self {
		case .key:
			return "key"
		case .title:
			return "title"
		case .summary:
			return "summary"
		case .isTermBased:
			return "is_term_based"
		case .providesCareerServices:
			return "provides_career_services"
		case .dateUpdated:
			return "updated_at"
		case .isGraduated:
			return "is_graduated"
		case .dateGraduated:
			return "graduation_date"
		case .isReadyForGraduation:
			return "is_ready_for_graduation"
		case .heroImage:
			return "hero_image"
		}
	}
	
}
