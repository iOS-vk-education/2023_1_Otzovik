//
//  UserProfile.swift
//  Otzovik
//
//  Created by  Alexander Fedoseev on 28.12.2023.
//

import Foundation

struct UserProfile {
    public var firstName: String = ""
    public var lastName: String = ""
    public var email: String = ""
    public var password: String = ""
    public var hei: String = ""
    public var department: String = ""
    
    static var firstName: String {
        get {
            if let value = UserDefaults.standard.string(forKey: "firstName") {
                return value
            } else {
                UserDefaults.standard.set("", forKey: "firstName")
                return ""
            }
        }
        set {
            UserDefaults.standard.set(newValue, forKey: "firstName")
        }
    }
    static var lastName: String {
        get {
            if let value = UserDefaults.standard.string(forKey: "lastName") {
                return value
            } else {
                UserDefaults.standard.set("", forKey: "lastName")
                return ""
            }
        }
        set {
            UserDefaults.standard.set(newValue, forKey: "lastName")
        }
    }
    static var email: String {
        get {
            if let value = UserDefaults.standard.string(forKey: "email") {
                return value
            } else {
                UserDefaults.standard.set("", forKey: "email")
                return ""
            }
        }
        set {
            UserDefaults.standard.set(newValue, forKey: "email")
        }
    }
    static var hei: String {
        get {
            if let value = UserDefaults.standard.string(forKey: "hei") {
                return value
            } else {
                UserDefaults.standard.set("", forKey: "hei")
                return ""
            }
        }
        set {
            UserDefaults.standard.set(newValue, forKey: "hei")
        }
    }
    static var department: String {
        get {
            if let value = UserDefaults.standard.string(forKey: "department") {
                return value
            } else {
                UserDefaults.standard.set("", forKey: "department")
                return ""
            }
        }
        set {
            UserDefaults.standard.set(newValue, forKey: "department")
        }
    }
    static var password: String {
        get {
            if let value = UserDefaults.standard.string(forKey: "password") {
                return value
            } else {
                UserDefaults.standard.set("", forKey: "password")
                return ""
            }
        }
        set {
            UserDefaults.standard.set(newValue, forKey: "password")
        }
    }
    
}
