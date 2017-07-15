//
//  ISO8601ExtendedDateTransform.swift
//  UDClientTests
//
//  Created by Omar Albeik on 7/14/17.
//  Copyright © 2017 Udacity. All rights reserved.
//

import ObjectMapper


public class ISO8601ExtendedDateTransform: DateFormatterTransform {
	
	init() {
		let formatter = DateFormatter()
		formatter.locale = Locale(identifier: "en_US_POSIX")
		formatter.dateFormat = "yyyy-MM-dd'T'HH:mm:ss.SSSZ"
		super.init(dateFormatter: formatter)
	}
	
}
