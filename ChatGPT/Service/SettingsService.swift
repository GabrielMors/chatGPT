//
//  SettingsService.swift
//  ChatGPT
//
//  Created by Gabriel Mors  on 15/06/23.
//

import Foundation
import Alamofire

enum ErrorProfile: Swift.Error {
    case fileNotFound(name: String)
    case fileDecodingFailed(name: String, Swift.Error)
    case errorURLRequest(Swift.Error)
    case errorRequest(AFError)
    case errorUrl(urlString: String)
    case errorDetail(detail: String)
}

class SettingsService {
    
    private let urlString: String = "https://run.mocky.io/v3/685426ae-3405-4690-91d5-52d8d788acab"
    //MARK: Nativa
    func getPerson(compleation: @escaping (Result<Person, ErrorProfile>)-> Void) {
        guard let url = URL(string: urlString) else {
            return compleation(.failure(ErrorProfile.errorUrl(urlString: urlString)))
        }
        
        URLSession.shared.dataTask(with: url) { data, response, error in
            DispatchQueue.main.async {
                if let error {
                    return compleation(.failure(ErrorProfile.errorURLRequest(error)))
                }
                
                guard let data = data else {
                    return compleation(.failure(ErrorProfile.errorDetail(detail: "Error data")))
                }
                
                do {
                    let person = try JSONDecoder().decode(Person.self,from: data)
                    compleation(.success(person))
                } catch {
                    compleation(.failure(ErrorProfile.errorURLRequest(error)))
                }
            }
        }.resume()
    }
    
    func getPersonAlamofire(completion: @escaping (Result<Person, ErrorProfile>) -> Void) {
        AF.request(urlString, method: .get).validate(statusCode: 200...299).responseDecodable(of: Person.self) { response in
            debugPrint(response)
            switch response.result {
            case .success(let success):
                completion(.success(success))
            case .failure(let error):
                completion(.failure(ErrorProfile.errorRequest(error)))
            }
        }
    }
    
    func getPersonFromJson(completion: (Result<Person, ErrorProfile>) -> Void) {
        if let url = Bundle.main.url(forResource: "person", withExtension: "json") {
            do {
                let data = try Data(contentsOf: url)
                let person: Person = try JSONDecoder().decode(Person.self, from: data)
                completion(.success(person))
                print("SUCCESS -> \(#function)")
            }catch {
                completion(.failure(ErrorProfile.fileDecodingFailed(name: "data", error)))
                print("ERROR -> \(#function)")
            }
        }
    }
    
}
