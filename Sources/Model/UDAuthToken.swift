//
//  UDAuthToken.swift
//  UDClient
//
//  Created by Omar Albeik on 9/16/17.
//

import Foundation


public class UDAuthToken {
	
	/// Token string
	public var token: String
	
	/// Token expiry date
	public var expiryDate: Date? {
		guard isValid else { return nil }
		return self.expiryDateFromPart(parts[1])
	}
	
	/// Token issue date
	public var issueDate: Date? {
		guard isValid else { return nil }
		return self.issueDateFromPart(parts[1])
	}
	
	/// Check is token is expired
	public var isExpired: Bool {
		guard let date = expiryDate else {
			return true
		}
		return date <= Date()
	}
	
	/// Create a UDAuthToken object
	///
	/// - Parameter token: token string
	public init(token: String) {
		self.token = token
	}
	
}

fileprivate extension UDAuthToken {
	
	var parts: [String] {
		return token.components(separatedBy: ".")
	}
	
	func decodePart(_ part: String) -> [String: Any]? {
		guard let decodedData = Data(base64Encoded: part) else {
			return nil
		}
		
		guard let json = try? JSONSerialization.jsonObject(with: decodedData, options: []) else {
			return nil
		}
		
		guard let dict = json as? [String: Any] else {
			return nil
		}
		
		return dict
	}
	
	func expiryDateFromPart(_ part: String) -> Date? {
		guard let decodedPart = decodePart(part) else {
			return nil
		}
		guard let timeStamp = decodedPart["exp"] as? Int else {
			return nil
		}
		return Date.init(timeIntervalSince1970: TimeInterval(timeStamp))
	}
	
	func issueDateFromPart(_ part: String) -> Date? {
		guard let decodedPart = decodePart(part) else {
			return nil
		}
		guard let timeStamp = decodedPart["iat"] as? Int else {
			return nil
		}
		return Date.init(timeIntervalSince1970: TimeInterval(timeStamp))
	}
	
	var isValid: Bool {
		return parts.count == 3
	}
	
}


// MARK: - Equatable
extension UDAuthToken: Equatable {
	
	public static func ==(lhs: UDAuthToken, rhs: UDAuthToken) -> Bool {
		return lhs.token == rhs.token
	}
	
}


// MARK: - CustomStringConvertible
extension UDAuthToken: CustomStringConvertible {
	
	public var description: String {
		return token
	}
	
}


// MARK: - CustomDebugStringConvertible
extension UDAuthToken: CustomDebugStringConvertible {
	
	public var debugDescription: String {
		return """
		Issue Date: \(issueDate?.description ?? "--")
		Expiry Date: \(expiryDate?.description ?? "--")
		Token: \(token)
		"""
	}
	
}
