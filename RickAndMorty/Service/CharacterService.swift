//
//  CharacterService.swift
//  RickAndMorty
//
//  Created by Atharian Rahmadani on 06/12/23.
//

import Foundation

struct CharacterService {
    
    enum CharacterServiceError: Error {
        case failed
        case failedToDecode
        case invalidStatusCode
    }
    
    func fetchCharacter() async throws -> [Character] {
        
        let url = URL(string: "https://rickandmortyapi.com/api/character")!
        let configuration = URLSessionConfiguration.ephemeral
        let (data, response) = try await URLSession(configuration: configuration).data(from: url)
        
        guard let response = response as? HTTPURLResponse,
              response.statusCode == 200 else {
            throw CharacterServiceError.invalidStatusCode
        }
        
        let decodedData = try JSONDecoder().decode(CharacterServiceResult.self, from: data)
        
        return decodedData.results
    }
}
