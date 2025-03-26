//
//  ApiServices.swift
//  CTE_BuyLeads
//
//  Created by Chandini on 25/03/25.
//

import Foundation

public class ApiServices {
    
    public init() {} // Required for external usage
    public func sendRawDataWithHeaders(parameters: [String: Any], headers: [String: String], completion: @escaping (Result<[String: Any], Error>) -> Void) {
        let urlString = "https://fcgapi.olx.in/dealer/mobile_api" // Replace with your API URL
        guard let url = URL(string: urlString) else { return }
        var request = URLRequest(url: url)
           request.httpMethod = "POST"
           request.setValue("application/json", forHTTPHeaderField: "Content-Type") // Set header for JSON
           for (key, value) in headers {
               request.setValue(value, forHTTPHeaderField: key)
           }
           // Convert parameters to JSON data
           do {
               request.httpBody = try JSONSerialization.data(withJSONObject: parameters, options: [])
           } catch {
               completion(.failure(error))
               return
           }
        let task = URLSession.shared.dataTask(with: request) { data, response, error in
        if let error = error {
            completion(.failure(error))
            return
        }
        guard let data = data else {
            completion(.failure(NSError(domain: "No Data", code: -1, userInfo: nil)))
            return
        }
        do {
            print(response as Any)
            let jsonResponse = try JSONSerialization.jsonObject(with: data, options: []) as? [String: Any]
            completion(.success(jsonResponse ?? [:]))
        } catch {
            print(response.debugDescription as Any)
            completion(.failure(error))
        }
    }
    
    task.resume()
    }

}
