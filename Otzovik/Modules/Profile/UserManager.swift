//
//  UserManager.swift
//  Otzovik
//
//  Created by Александр Денисов on 08.12.2023.
//

import Foundation

final class UserManager {
    func loadUserInfo(completion: @escaping ((User) -> Void)) {
        let authUser: User = .init(name: "Сарыглар Начын",
                               profileImageURL: "avatar2",
                               university: "МГТУ им. Н.Э. Баумана",
                               faculty: "Информатика и вычислительные системы управления",
                               cathedra: "ИУ8")
        completion(authUser)
    }
}
