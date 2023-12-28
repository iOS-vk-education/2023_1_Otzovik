//
//  RegistrationModel.swift
//  Otzovik
//
//  Created by  Alexander Fedoseev on 11.11.2023.
//

import Foundation
import FirebaseAuth
import FirebaseFirestore
import Firebase

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
            return (false, "6")
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
            return (false, "7")
        }
    }
    public func registration(completionHandler: @escaping (Bool, String) -> Void) {
        if checkLoginValid().0 && checkPasswordValid().0 {
            NetworkEntranceManager.shared.registration(email: email, password: password) { isOk, message, authResult in
                if isOk {
                    if let authResult = authResult {
                        let db = Firestore.firestore()
                        db.collection("Profile").document(authResult.user.uid).setData([
                            "name": "\(self.firstName) \(self.lastName)",
                            "university": self.hei,
                            "faculty": "",
                            "chair": self.department,
                            "profileImageName": "profileImage1.jpg"
                        ])
                        UserProfile.firstName = self.firstName
                        UserProfile.lastName = self.lastName
                        UserProfile.email = self.email
                        UserProfile.hei = self.hei
                        UserProfile.department = self.department
                        LoginModel.shared.login { errorMessage in
                            if let errorMessage = errorMessage {
                                completionHandler(false, errorMessage)
                                return
                            } else {
                                completionHandler(true, message + " 1")
                                return
                            }
                        }
                        completionHandler(true, message + " 2")
                        return
                    } else {
                        completionHandler(false, message + " 3")
                        return
                    }
                    
                } else {
                    completionHandler(false, message + " 4")
                    return
                }
            }
        } else {
            if !checkLoginValid().0 {
                completionHandler(false, checkLoginValid().1)
                return
            }
            if !checkPasswordValid().0 {
                completionHandler(false, checkPasswordValid().1)
                return
            }
            completionHandler(false, "8")
            return
        }

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
