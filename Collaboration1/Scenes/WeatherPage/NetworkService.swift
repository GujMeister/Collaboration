//
//  NetworkService.swift
//  Collaboration1
//
//  Created by Nodiko Gachava on 18.05.24.
//

import UIKit

enum NetworkError: Error {
    case decodeError
    case wrongResponse
    case wrongStatusCode(code: Int)
}

class NetworkService {
    static var networkService = NetworkService()
    
    private init(){}
    func getData<T: Decodable>(urlString: String, completion: @escaping (Result<T,Error>) ->(Void)) {
        let url = URL(string: urlString)!

        URLSession.shared.dataTask(with: URLRequest(url: url)) { data, response, error in
            
            if let error {
                //ერორის დაპრინტვა
                print(error.localizedDescription)
            }
            
            guard let response = response as? HTTPURLResponse else {
                return
            }
            
            guard (200...299).contains(response.statusCode) else {
                //არასწორი პასუხი თუ მივიღე რომ გავიგო
                print("wrong response")
                return
            }
            //მონაცემის არ ქონაზე შემოწმება
            guard let data else { return }

            do {
                let decoder = JSONDecoder()
                let object = try decoder.decode(T.self, from: data)
                
            } catch {
                //ერორის გადმოწოდება
                completion(.failure(NetworkError.decodeError))
            }
        }.resume()
    }
}
