//
//  UDImageField.swift
//  UDClient
//
//  Created by Omar Albeik on 7/15/17.
//  Copyright © 2017 Udacity. All rights reserved.
//

import Foundation


public enum UDImageField {
	case url
	case width
	case height
}

extension UDImageField: CustomStringConvertible {
	
	public var description: String {
		switch self {
		case .url:
			return "url"
		case .width:
			return "width"
		case .height:
			return "height"
		}
	}
	
}

