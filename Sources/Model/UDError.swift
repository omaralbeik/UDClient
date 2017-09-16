//
//  UDError.swoft
//  UDClient
//
//  Created by Omar Albeik on 9/16/17.
//  Copyright © 2017 Omar Albeik. All rights reserved.
//

import Foundation


public enum UDError: Error {
	case invalidRequest
	case noData
	case noUser
	case server(error: Error)
}


extension UDError: LocalizedError {
	
	public var errorDescription: String? {
		switch self {
		case .invalidRequest:
			return "Unable to form request to server"
		case .noData:
			return "Unable to parse data from server"
		case .noUser:
			return "Unable to get user info from server"
		case .server(error: let error):
			return error.localizedDescription
		}
	}
	
}
