//
//  UserModel.swift
//  Otzovik
//
//  Created by  Alexander Fedoseev on 11.11.2023.
//

import Foundation
import FirebaseAuth

class UserModel {
    private init() {}
    static let shared = UserModel()
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
    public func checkLoginAndPasswordTmp(login: String, password: String, completion: @escaping (Error?) -> Void) {
        Auth.auth().signIn(withEmail: login, password: password) {
            authResult, error in
            if error != nil {
                completion(error)
            } else {
                completion(nil)
            }
            
        }
    }
}
