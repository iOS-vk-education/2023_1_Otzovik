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
    func loadUniversities2() {
        let ref = Database.database().reference().child("universities")

        let group = DispatchGroup()

        group.enter()

        ref.observeSingleEvent(of: .value) { snapshot in
            guard let data = try? JSONSerialization.data(withJSONObject: snapshot.value as Any),
                  let universities = try? JSONDecoder().decode([University].self, from: data) else {
                group.leave()
                return
            }

            self.all_universities = universities
            print(self.all_universities[0])
        }

        group.notify(queue: .main) {
            print(self.all_universities)
            if let encodedData = try? PropertyListEncoder().encode(self.all_universities) {
                UserDefaults.standard.set(encodedData, forKey: "all_univers")
                
            }
        }
    }
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
    
//    func loadUniversities(completion: @escaping (([University]) -> Void)) {
//        DispatchQueue.main.asyncAfter(deadline: .now() + 0.1) {
//            let allUniversities: [University] = [
//                .init(abbreviation: "НИУ ВШЭ", fullName: "Высшая школа экономики"),
//                .init(abbreviation: "МАИ", fullName: "Московский авиационный институт"),
//                .init(abbreviation: "МПУ", fullName: "Московский политехнический университет"),
//                .init(abbreviation: "МГИМО", fullName: "Московский государственный инстиут международных отношений"),
//                .init(abbreviation: "МГТУ им. Н.Э. Баумана", fullName: "Московский государственный технический университет"),
//                .init(abbreviation: "РУТ МИИТ", fullName: "Российский университет транспорта"),
//                .init(abbreviation: "МПГУ", fullName: "Московский педагогический государственный университет"),
//                .init(abbreviation: "НИУ МЭИ", fullName: "Московский энергетический институт"),
//                .init(abbreviation: "НИЯУ МИФИ", fullName: "Московский инженерно-физический институт"),
//                .init(abbreviation: "РГСУ", fullName: "Российский государственный социальный университет")
//            ]
//
//            completion(allUniversities)
//        }
//    }
    func loadFaculties() -> [Faculty] {
        let allFaculties: [Faculty] = [
            .init(name: "ИУ"),
            .init(name: "РТ"),
            .init(name: "СМ"),
            .init(name: "МТ"),
            .init(name: "РК"),
            .init(name: "Л"),
            .init(name: "ИУ"),
            .init(name: "РТ"),
            .init(name: "СМ"),
            .init(name: "МТ"),
            .init(name: "РК"),
            .init(name: "Л"),
            .init(name: "ИУ"),
            .init(name: "РТ"),
            .init(name: "СМ"),
            .init(name: "МТ"),
            .init(name: "РК"),
            .init(name: "Л"),
            .init(name: "ИУ"),
            .init(name: "РТ"),
            .init(name: "СМ"),
            .init(name: "МТ"),
            .init(name: "РК"),
            .init(name: "Л")
        ]
        return allFaculties
    }
}
