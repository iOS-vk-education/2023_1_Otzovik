//
//  UniversityManager.swift
//  Otzovik
//
//  Created by Сергей Мирошниченко on 27.11.2023.
//

import Foundation
import Firebase
import Reachability

final class Manager{
    var all_universities: [University] = []
    
    func loadUniversities(completion: @escaping (Result<[University], Error>) -> Void) {
        guard let reachability = try? Reachability() else {
            let error = NSError(domain: "No internet connection", code: 100, userInfo: nil)
            completion(.failure(error))
            return
        }

        guard reachability.connection != .unavailable else {
            let error = NSError(domain: "No internet connection", code: 101, userInfo: nil)
            completion(.failure(error))
            return
        }

        let ref = Database.database().reference().child("universities")

        ref.observeSingleEvent(of: .value) { snapshot in
            do {
                guard let data = try? JSONSerialization.data(withJSONObject: snapshot.value as Any),
                      let universities = try? JSONDecoder().decode([University].self, from: data) else {
                    throw NSError(domain: "Data decoding error", code: 0, userInfo: nil)
                }

                self.all_universities = universities
                if let encodedData = try? PropertyListEncoder().encode(self.all_universities) {
                    UserDefaults.standard.set(encodedData, forKey: "all_univers")
                    completion(.success(universities))
                } else {
                    throw NSError(domain: "Encoding error", code: 1, userInfo: nil)
                }
            } catch {
                completion(.failure(error))
            }
        }
    }
}
