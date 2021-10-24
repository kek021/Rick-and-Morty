//
//  Network.swift
//  RickAndMorty
//
//  Created by Александр Жуков on 24.10.2021.
//

import Foundation
import Alamofire

class Network{
    func getData(urlString: String, completion: @escaping (Result<Data, Error>) -> Void){
        AF.request(urlString).responseJSON { response in
                DispatchQueue.main.async {
                    if let error = response.error{
                    completion(.failure(error))
                    return
                }
                    guard let data = response.data else { return }
                completion(.success(data))
            }
        }
    }
}
