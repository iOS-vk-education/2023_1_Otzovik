//
//  allUniversities.swift
//  Otzovik
//
//  Created by Сергей Мирошниченко on 27.11.2023.
//

import Foundation

struct Teacherr: Codable {
    var name: String
    var rating: Float
}

struct Department: Codable {
    var name: String
    var teachers: [Teacherr]
}

struct University: Codable {
    var name: String
    var fullName: String
    var departments: [Department]
}
struct Faculty{
    var name: String
}
