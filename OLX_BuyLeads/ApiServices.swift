//
//  ApiServices.swift
//  CTE_BuyLeads
//
//  Created by Chandini on 25/03/25.
//

import Foundation

public class ApiServices {
    
    public init() {} // Required for external usage
    
    public func fetchData(from urlString: String, completion: @escaping (Result<Data, Error>) -> Void) {
        guard let url = URL(string: urlString) else {
            completion(.failure(NSError(domain: "Invalid URL", code: 400, userInfo: nil)))
            return
        }

        let task = URLSession.shared.dataTask(with: url) { data, response, error in
            if let error = error {
                completion(.failure(error))
                return
            }

            guard let httpResponse = response as? HTTPURLResponse, (200...299).contains(httpResponse.statusCode) else {
                completion(.failure(NSError(domain: "Invalid Response", code: 500, userInfo: nil)))
                return
            }

            if let data = data {
                completion(.success(data))
            } else {
                completion(.failure(NSError(domain: "No Data", code: 404, userInfo: nil)))
            }
        }
        task.resume()
    }
}
