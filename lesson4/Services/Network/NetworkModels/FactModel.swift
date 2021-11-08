//
//  CatsModels.swift
//  lesson4
//
//  Created by Тарас Евченко on 08.11.2021.
//

import Foundation

struct Fact: Codable {
    let status: Status
    let id, user, text: String
    let v: Int
    let source, updatedAt, type, createdAt: String
    let deleted, used: Bool
    
    enum CodingKeys: String, CodingKey {
        case status
        case id = "_id"
        case user, text
        case v = "__v"
        case source, updatedAt, type, createdAt, deleted, used
    }
}

// MARK: - Status
struct Status: Codable {
    let verified: Bool
    let sentCount: Int
}
