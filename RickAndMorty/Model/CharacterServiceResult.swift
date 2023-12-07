//
//  CharacterServiceResult.swift
//  RickAndMorty
//
//  Created by Atharian Rahmadani on 06/12/23.
//

struct CharacterServiceResult: Codable {
    let results: [Character]
}

struct Character: Codable {
    let id: Int
    let name: String
    let image: String
}
