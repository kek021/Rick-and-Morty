//
//  Parser.swift
//  RickAndMorty
//
//  Created by Александр Жуков on 24.10.2021.
//

import Foundation

class Parser{
    
    let network = Network()
    
    func parseCharacters(urlString: String, response: @escaping (Characters?) -> Void){
        network.getData(urlString: urlString) { (results) in
            switch results {
            
            case .success(let data):
                do{
                    let characters = try JSONDecoder().decode(Characters.self, from: data)
                  response(characters)
                } catch let jsonError {
                    print("Failed to decode JSON", jsonError)
                    response(nil)
                }
            case .failure(let error):
                print("Error received requesting data: \(error.localizedDescription)")
                response(nil)
            }
        }
    }
}

