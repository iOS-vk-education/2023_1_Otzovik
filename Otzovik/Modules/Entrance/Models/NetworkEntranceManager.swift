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
    
    public func registration(email: String, password: String, completionHandler: @escaping (Bool) -> Void) {
        Auth.auth().createUser(withEmail: email, password: password) { authResult, error in
          // Проверка на ошибки при регистрации
          if let error = error {
            print("Ошибка при регистрации нового пользователя: \(error.localizedDescription)")
            completionHandler(false)
          } else {
              if let authResult = authResult {
                  print("Пользователь успешно зарегистрирован с ID: \(authResult.user.uid)")
                  completionHandler(true)
              } else {
                  print("Неизвестная ошибка при регистрации нового пользователя.")
                  completionHandler(false)
              }
          }
        }
    }
    public func login() {
        
    }
}
