//
//  UniversityManager.swift
//  Otzovik
//
//  Created by Сергей Мирошниченко on 27.11.2023.
//

import Foundation

final class Manager{
    
    func loadUniversities(completion: @escaping (([University]) -> Void)) {
        DispatchQueue.main.asyncAfter(deadline: .now() + 0.1) {
            let allUniversities: [University] = [
                .init(abbreviation: "НИУ ВШЭ", fullName: "Высшая школа экономики"),
                .init(abbreviation: "МАИ", fullName: "Московский авиационный институт"),
                .init(abbreviation: "МПУ", fullName: "Московский политехнический университет"),
                .init(abbreviation: "МГИМО", fullName: "Московский государственный инстиут международных отношений"),
                .init(abbreviation: "МГТУ им. Н.Э. Баумана", fullName: "Московский государственный технический университет"),
                .init(abbreviation: "РУТ МИИТ", fullName: "Российский университет транспорта"),
                .init(abbreviation: "МПГУ", fullName: "Московский педагогический государственный университет"),
                .init(abbreviation: "НИУ МЭИ", fullName: "Московский энергетический институт"),
                .init(abbreviation: "НИЯУ МИФИ", fullName: "Московский инженерно-физический институт"),
                .init(abbreviation: "РГСУ", fullName: "Российский государственный социальный университет")
                
            ]
            
            completion(allUniversities)
        }
    }
    func loadFaculties() -> [Faculty] {
        let allFaculties: [Faculty] = [
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
