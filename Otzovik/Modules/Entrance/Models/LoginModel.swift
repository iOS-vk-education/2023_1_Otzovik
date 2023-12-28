//
//  LoginModel.swift
//  Otzovik
//
//  Created by  Alexander Fedoseev on 11.11.2023.
//

import Foundation
import FirebaseAuth

class LoginModel {
    
    private func checkLoginValid() -> (Bool, String) {
        if login.count >= EntranceConstantes.loginMinLength && login.count <= EntranceConstantes.loginMaxLength {
            return (true, "")
        } else {
            if login.count < EntranceConstantes.loginMinLength {
                return (false, "Минимальная длина логина \(EntranceConstantes.loginMinLength) симолов")
            }
            if login.count > EntranceConstantes.loginMaxLength {
                return (false, "Максимальная длина логина \(EntranceConstantes.loginMaxLength) симолов")
            }
            return (false, "")
        }
    }
    private func checkPasswordValid() -> (Bool, String) {
        if password.count >= EntranceConstantes.passwordMinLength && password.count <= EntranceConstantes.passwordMaxLength {
            return (true, "")
        } else {
            if password.count < EntranceConstantes.passwordMinLength {
                return (false, "Минимальная длина пароля \(EntranceConstantes.passwordMinLength) симолов")
            }
            if password.count > EntranceConstantes.passwordMaxLength {
                return (false, "Максимальная длина пароля \(EntranceConstantes.passwordMaxLength) симолов")
            }
            return (false, "")
        }
    }
    public func setLogin(login: String) {
        self.login = login
    }
    public func setPassword(password: String) {
        self.password = password
    }
    public func checkLoginAndPassword() -> (Bool, String) {
        let loginValid = checkLoginValid()
        let passwordValid = checkPasswordValid()
        if loginValid.0 && passwordValid.0 {
            return(true, "")
        } else {
            if !loginValid.0 {
                return(false, loginValid.1)
            }
            if !passwordValid.0 {
                return(false, passwordValid.1)
            }
        }
        return(false, "")
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
    private init() {}
    static let shared = LoginModel()
    private var login: String = ""
    private var password: String = ""
    
}
