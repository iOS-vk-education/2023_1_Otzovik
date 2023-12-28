//
//  RegistrationModel.swift
//  Otzovik
//
//  Created by  Alexander Fedoseev on 11.11.2023.
//

import Foundation
import FirebaseAuth

class RegistrationModel {

    private func checkLoginValid() -> (Bool, String) {
        if email.count >= EntranceConstantes.loginMinLength && email.count <= EntranceConstantes.loginMaxLength {
            return (true, "")
        } else {
            if email.count < EntranceConstantes.loginMinLength {
                return (false, "Минимальная длина логина \(EntranceConstantes.loginMinLength) симолов")
            }
            if email.count > EntranceConstantes.loginMaxLength {
                return (false, "Максимальная длина логина \(EntranceConstantes.loginMaxLength) симолов")
            }
            return (false, "")
        }
    }
    private func checkPasswordValid() -> (Bool, String) {
        if password.count >= EntranceConstantes.passwordMinLength && password.count <= EntranceConstantes.passwordMaxLength {
            if password == confirmation {
                return (true, "")
            } else {
                return (false, "Пароль и его подтвержение не совпадают")
            }
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
    public func registration(completionHandler: @escaping (Bool, String) -> Void) {
        if checkLoginValid().0 && checkPasswordValid().0 {
            NetworkEntranceManager.shared.registration(email: email, password: password) { isOk, message in
                if isOk {
                    UserProfile.firstName = self.firstName
                    UserProfile.lastName = self.lastName
                    UserProfile.email = self.email
                    UserProfile.hei = self.hei
                    UserProfile.department = self.department
                    LoginModel.shared.login { errorMessage in
                        if let errorMessage = errorMessage {
                            completionHandler(false, errorMessage)
                        } else {
                            completionHandler(true, message)
                        }
                    }
                    completionHandler(true, message)
                } else {
                    completionHandler(false, message)
                }
            }
        } else {
            if !checkLoginValid().0 {
                completionHandler(false, checkLoginValid().1)
            }
            if !checkPasswordValid().0 {
                completionHandler(false, checkPasswordValid().1)
            }
        }
        completionHandler(false, "")
    }
    private init() {}
    static let shared = RegistrationModel()
    
    public var firstName: String = ""
    public var lastName: String = ""
    public var email: String = ""
    public var password: String = ""
    public var confirmation: String = ""
    public var hei: String = ""
    public var faculty: String = ""
    public var department: String = ""
    
    
}
