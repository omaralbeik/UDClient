//
//  Extensions.swift
//  UDClient
//
//  Created by Omar Albeik on 7/14/17.
//  Copyright © 2017 Udacity. All rights reserved.
//

import Foundation


extension Date {
	
	init?(ISO8601string: String) {
		let formatter = DateFormatter()
		formatter.locale = Locale(identifier: "en_US_POSIX")
		formatter.dateFormat = "yyyy-MM-dd'T'HH:mm:ss.SSSZ"
		
		guard let date = formatter.date(from: ISO8601string) else {
			return nil
		}
		self = date
	}
	
}
