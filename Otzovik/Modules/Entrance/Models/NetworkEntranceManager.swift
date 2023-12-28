//
//  NetworkEntranceManager.swift
//  Otzovik
//
//  Created by  Alexander Fedoseev on 26.12.2023.
//

import Foundation
import Firebase
import FirebaseDatabase
import FirebaseAuth

final class NetworkEntranceManager {
    
    private init() {}
    static let shared = NetworkEntranceManager()
    
    public func registration(email: String, password: String, completionHandler: @escaping (Bool, String, AuthDataResult?) -> Void) {
        Auth.auth().createUser(withEmail: email, password: password) { authResult, error in
          if let error = error {
              let message = "Ошибка при регистрации нового пользователя: \(error.localizedDescription)"
              print(message)
              completionHandler(false, message, nil)
          } else {
              if let authResult = authResult {
                  print("Пользователь успешно зарегистрирован с ID: \(authResult.user.uid)")
                  completionHandler(true, "", authResult)
              } else {
                  let message = "Неизвестная ошибка при регистрации нового пользователя"
                  print(message)
                  completionHandler(false, message, nil)
              }
          }
        }
    }
    public func login() {
        
    }
}
