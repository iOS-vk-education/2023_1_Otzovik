//
//  TeacherManager.swift
//  Otzovik
//
//  Created by Начын Сарыглар on 27.11.2023.
//

import Foundation

final class TeacherManager {
    // escaping closure
    func loadTeachers(completion: @escaping (([Teacher]) -> Void)) {
        DispatchQueue.main.asyncAfter(deadline: .now()) {
            let products: [Teacher] = [
                .init(fio: "Александрова Галина Васильевна",
                      university: "МГТУ им. Баумана",
                      faculty: "Информатики и системы управления",
                      chair: "Компьютерная безопасность ИУ8",
                      imageURL: "assets/image.png",
                      rating: 4.2,
                      degree: "Доцент"),
                .init(fio: "Кулагин Олег Игоревич",
                      university: "МГТУ им. Баумана",
                      faculty: "Информатики и системы управления",
                      chair: "Компьютерная безопасность РК1",
                      imageURL: "assets/image.png",
                      rating: 4.2,
                      degree: "Доцент"),
                .init(fio: "Беляева Валентина Николаевна",
                      university: "МГТУ им. Баумана",
                      faculty: "Информатики и системы управления",
                      chair: "Компьютерная безопасность РК2",
                      imageURL: "assets/image.png",
                      rating: 4.2,
                      degree: "Доцент"),
                .init(fio: "Бердникова Ольга Юрьевна",
                      university: "МГТУ им. Баумана",
                      faculty: "Информатики и системы управления",
                      chair: "Компьютерная безопасность РК3",
                      imageURL: "assets/image.png",
                      rating: 4.2,
                      degree: "Доцент"),
            ]
            
            completion(products)
        }
    }
}
