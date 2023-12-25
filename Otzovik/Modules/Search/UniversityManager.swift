//
//  UniversityManager.swift
//  Otzovik
//
//  Created by Сергей Мирошниченко on 27.11.2023.
//

import Foundation
import Firebase

final class Manager{
    var all_universities: [University] = []

    func loadUniversities(completion: @escaping () -> Void) {
        let ref = Database.database().reference().child("universities")
        
        ref.observeSingleEvent(of: .value) { snapshot in
            guard let data = try? JSONSerialization.data(withJSONObject: snapshot.value as Any),
                  let universities = try? JSONDecoder().decode([University].self, from: data) else {
                completion() // Вызываем замыкание при ошибке
                return
            }
            
            self.all_universities = universities
            if let encodedData = try? PropertyListEncoder().encode(self.all_universities) {
                UserDefaults.standard.set(encodedData, forKey: "all_univers")
                completion() // Вызываем замыкание успешно
            }
        }
    }
}
