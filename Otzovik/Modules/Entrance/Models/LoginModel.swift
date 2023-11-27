//
//  LoginModel.swift
//  Otzovik
//
//  Created by  Alexander Fedoseev on 11.11.2023.
//

import Foundation
import FirebaseAuth

class LoginModel {
    private init() {}
    static let shared = LoginModel()
    private var login: String = ""
    private var password: String = ""
    private let loginMinLength:Int = 3
    private let passwordMinLength:Int = 4
    private let loginMaxLength:Int = 8
    private let passwordMaxLength:Int = 8
    
    public func checkLoginValid(login: String) -> Bool {
        return login.count >= loginMinLength && login.count <= loginMaxLength
    }
    public func checkPasswordValid(password: String) -> Bool {
        return password.count >= passwordMinLength && password.count <= passwordMaxLength
    }
    public func checkLoginLessMax(login: String) -> Bool {
        return login.count <= loginMaxLength
    }
    public func checkPasswordLessMax(password: String) -> Bool {
        return password.count <= passwordMaxLength
    }
    public func setLogin(login: String) {
        self.login = login
    }
    public func setPassword(password: String) {
        self.password = password
    }
    public func checkLoginAndPassword() -> Bool {
        return true
    }
    public func login(completion: @escaping (String?) -> Void) {
        Auth.auth().signIn(withEmail: self.login, password: self.password) {
            authResult, error in
            if let error = error {
                print(error)
                completion(error.localizedDescription)
            } else {
                completion(nil)
            }
        }
    }
}
