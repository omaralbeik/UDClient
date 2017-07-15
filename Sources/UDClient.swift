//
//  UDClient.swift
//  UDClient
//
//  Created by Omar Albeik on 7/14/17.
//  Copyright © 2017 Udacity. All rights reserved.
//

import Foundation
import Alamofire
import AlamofireObjectMapper
import SwiftyJSON
import JWTDecode


public class UDClient {
	
	/// Shared instance of UDClient
	public static var shared: UDClient {
		struct Static {
			static let instance = UDClient()
		}
		return Static.instance
	}
	
	/// Request a JWT token and its expiry date for a user
	public func requestToken(email: String, password: String,
	                  _ completion: @escaping (_ error: Error?, _ token: JWT?) -> Void) {
		
		let body: JSON = [
			"email": email,
			"password": password,
			"next": "www.udacity.com"
		]
		
		let request = createRequest(url: authUrl, headers: jsonHeaders, jsonBody: body)!
		Alamofire.request(request).validate(statusCode: 200..<300).responseString { response in
			switch response.result {
			case .success(let token):
				completion(nil, try? decode(jwt: token))
			case .failure(let error):
				completion(error, nil)
			}
		}
	}
	
	public func fetchUserInfo(token: String, fields: [UDUserField],
	                   _ completion: @escaping (_ error: Error?, _ user: UDUser?) -> Void) {
		let body = UDUser.generateQuery(fields: fields)
		let request = createRequest(url: classroomUrl, headers: authorizedJsonHeaders(token: token), stringBody: body)!
		
		Alamofire.request(request).validate(statusCode: 200..<300).responseObject { (response: DataResponse<UDUser>) in
			switch response.result {
			case .success(let user):
				completion(response.error, user)
			case .failure(let error):
				completion(error, nil)
			}
		}
	}
	
}


public extension UDClient {
	
	public var authUrl: URL {
		return URL(string: "https://hoth.udacity.com/authenticate")!
	}
	
	public var classroomUrl: URL {
		return URL(string: "https://classroom-content.udacity.com/api/v1/graphql")!
	}
	
	public var jsonHeaders: HTTPHeaders {
		return ["Content-Type": "application/json", "Accept" : "application/json"]
	}
	
	public func authorizedJsonHeaders(token: String) -> HTTPHeaders {
		let headers = ["Content-Type": "application/json",
		               "Accept" : "application/json",
		               "Authorization": "Bearer \(token)"]
		return headers
	}
	
	fileprivate func createRequest(url: URL, headers: HTTPHeaders, jsonBody: JSON) -> URLRequest? {
		guard var request = try? URLRequest(url: url, method: .post, headers: headers) else {
			return nil
		}
		guard let httpBody = try? jsonBody.rawData() else {
			return nil
		}
		request.httpBody = httpBody
		return request
	}
	
	fileprivate func createRequest(url: URL, headers: HTTPHeaders, stringBody: String) -> URLRequest? {
		guard var request = try? URLRequest(url: url, method: .post, headers: headers) else {
			return nil
		}
		request.httpBody = stringBody.data(using: .utf8, allowLossyConversion: false)
		return request
	}
	
}
