//
//  UDClient.swift
//  UDClient
//
//  Created by Omar Albeik on 7/14/17.
//  Copyright © 2017 Udacity. All rights reserved.
//

import Foundation
import Alamofire


public class UDClient {
	
	/// Shared instance of UDClient
	public static let shared = UDClient()
	
	/// Auth endpoint url
	fileprivate var authUrl = URL(string: "https://hoth.udacity.com/authenticate")!
	
	/// Classroom API url
	fileprivate var classroomUrl = URL(string: "https://classroom-content.udacity.com/api/v1/graphql")!
	
	/// Create a new instane of UDClient
	///
	/// - Parameters:
	///   - authUrl: Auth endpoint url
	///   - classroomUrl: Classroom API url
	public init(authUrl: URL, classroomUrl: URL) {
		self.authUrl = authUrl
		self.classroomUrl = classroomUrl
	}
	
	private init() {
		// This prevents others from using the default '()' initializer for this class.
	}
	
	/// Request a JWT token for a user
	public func requestToken(email: String, password: String, _ completion: @escaping (_ token: UDAuthToken?, _ error: UDError?) -> Void) {
		let body = [
			"email": email,
			"password":	password,
			"next": "www.udacity.com"
		]
		
		guard let request = createRequest(url: authUrl, headers: jsonHeaders, body: body) else {
			completion(nil, .invalidRequest)
			return
		}
		
		Alamofire.request(request).validate(statusCode: 200..<300).responseString { response in
			switch response.result {
			case .success(let string):
				completion(UDAuthToken(string: string), nil)
			case .failure(let error):
				completion(nil, .server(error: error))
			}
		}
	}
	
	public func fetchUserInfo(token: UDAuthToken, fields: [UDUser.fields], _ completion: @escaping (_ user: UDUser?, _ error: UDError?) -> Void) {
		let body = UDUser.generateQuery(fields: fields)
		
		guard let request = createRequest(url: classroomUrl, headers: authorizedJsonHeaders(token: token), stringBody: body) else {
			completion(nil, .invalidRequest)
			return
		}
		
		Alamofire.request(request).validate(statusCode: 200..<300).responseJSON { response in
			switch response.result {
			case .success(let data):
				
				guard let dict = data as? [String: Any] else {
					completion(nil, .noData)
					return
				}
				
				guard let dataDict = dict["data"] as? [String: Any] else {
					completion(nil, .noData)
					return
				}
				
				guard let userDict = dataDict["user"] as? [String: Any] else {
					completion(nil, .noUser)
					return
				}
				
				guard let userJson = try? JSONSerialization.data(withJSONObject: userDict, options: .prettyPrinted) else {
					completion(nil, .noUser)
					return
				}
				
				guard let user = UDUser(json: userJson) else {
					completion(nil, .noUser)
					return
				}
				
				completion(user, nil)
				
			case .failure(let error):
				completion(nil, .server(error: error))
			}
		}
	}
	
}


fileprivate extension UDClient {
	
	fileprivate var jsonHeaders: HTTPHeaders {
		return ["Content-Type": "application/json", "Accept" : "application/json"]
	}
	
	fileprivate func authorizedJsonHeaders(token: UDAuthToken) -> HTTPHeaders {
		var headers = jsonHeaders
		headers["Authorization"] = "Bearer \(token.string)"
		return headers
	}
	
	fileprivate func createRequest(url: URL, headers: [String: String], body: [String: Any]) -> URLRequest? {
		var request = URLRequest(url: url)
		request.httpMethod = "POST"
		request.allHTTPHeaderFields = headers
		request.timeoutInterval = 10
		
		if let bodyData = try? JSONSerialization.data(withJSONObject: body, options: .prettyPrinted) {
			request.httpBody = bodyData
		}
		
		return request
	}
	
	fileprivate func createRequest(url: URL, headers: [String: String], stringBody: String) -> URLRequest? {
		var request = URLRequest(url: url)
		request.httpMethod = "POST"
		request.allHTTPHeaderFields = headers
		request.httpBody = stringBody.data(using: .utf8)
		return request
	}
	
}
