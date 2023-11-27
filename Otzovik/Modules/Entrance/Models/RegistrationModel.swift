//
//  RegistrationModel.swift
//  Otzovik
//
//  Created by  Alexander Fedoseev on 11.11.2023.
//

import Foundation

class RegistrationModel {
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
