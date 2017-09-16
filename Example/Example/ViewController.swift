//
//  ViewController.swift
//  Example
//
//  Created by Omar Albeik on 9/15/17.
//  Copyright © 2017 Omar Albeik. All rights reserved.
//

import UIKit
import UDClient

class ViewController: UIViewController {
	
	var token: UDAuthToken?
	
	@IBOutlet weak var emailTextField: UITextField!
	
	@IBOutlet weak var resultTextView: UITextView!
	@IBOutlet weak var passwordTextField: UITextField!
	
	override func viewDidLoad() {
		super.viewDidLoad()
		
		emailTextField.text = "omaralbeik@gmail.com"
		
	}
	
	@IBAction func didTapRequestTokenButton(_ sender: UIButton) {
		view.endEditing(true)
		
		guard let email = emailTextField.text, !email.isEmpty else {
			self.resultTextView.textColor = .red
			self.resultTextView.text = "No Email!"
			return
		}
		
		guard let password = passwordTextField.text, !password.isEmpty else {
			self.resultTextView.textColor = .red
			self.resultTextView.text = "No Password!"
			return
		}
		
		UDClient.shared.requestToken(email: email, password: password) { token, error in
			if let err = error {
				DispatchQueue.main.async {
					self.resultTextView.textColor = .red
					self.resultTextView.text = err.localizedDescription
				}
				return
			}
			
			DispatchQueue.main.async {
				self.token = token
				self.resultTextView.textColor = .black
				self.resultTextView.text = token?.debugDescription
			}
		}
	}
	
	@IBAction func didTapRequestUserInfoButton(_ sender: UIButton) {
		view.endEditing(true)

		guard let authToken = self.token else {
			self.resultTextView.textColor = .red
			self.resultTextView.text = "No token found, request token first!"
			return
		}
		
		UDClient.shared.fetchUserInfo(token: authToken, keys: UDUser.allKeys) { user, error in
			if let err = error {
				DispatchQueue.main.async {
					self.resultTextView.textColor = .red
					self.resultTextView.text = err.localizedDescription
				}
				return
			}
			
			DispatchQueue.main.async {
				self.resultTextView.textColor = .black
				self.resultTextView.text = user?.debugDescription
			}
		}
		
	}
	
	
	
}

