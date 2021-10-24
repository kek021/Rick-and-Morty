//
//  CharactersModel.swift
//  RickAndMorty
//
//  Created by Александр Жуков on 24.10.2021.
//

import Foundation

struct Characters: Codable {
    var results: [Results]
    let info: Info
}

struct Info: Codable {
    let count, pages: Int
    let next: String?
}

struct Results: Codable {
    let id: Int
    let name: String
    let status: Status
    let species: String
    let gender: String
    let origin, location: Location
    let image: String
    let created: String
}


struct Location: Codable {
    let name: String
}


enum Status: String, Codable {
    case alive = "Alive"
    case dead = "Dead"
    case unknown = "unknown"
}

