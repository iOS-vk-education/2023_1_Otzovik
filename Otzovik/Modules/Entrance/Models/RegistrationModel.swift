//
//  RegistrationModel.swift
//  Otzovik
//
//  Created by  Alexander Fedoseev on 11.11.2023.
//

import Foundation
import FirebaseAuth

class RegistrationModel {
    
    public func registration(completion: @escaping (Error?) -> Void) {
        /*Auth.auth().createUser(withEmail: self.email, password: self.password) { registrationResult, error in
            if error != nil {
                completion(error)
            } else {
                Auth.auth().signIn(withEmail: self.email, password: self.password) {
                    authResult, error in
                    if error != nil {
                        completion(error)
                    } else {
                        completion(nil)
                    }
                    
                }
            }
        }*/
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
