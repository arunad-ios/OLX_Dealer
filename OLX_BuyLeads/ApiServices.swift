//
//  ApiServices.swift
//  CTE_BuyLeads
//
//  Created by Chandini on 25/03/25.
//

import Foundation

public class ApiServices {
    
    public init() {} // Required for external usage
    public func sendRawDataWithHeaders(parameters: [String: Any], headers: [String: String],url : String,authentication: String, completion: @escaping (Result<[String: Any], Error>) -> Void) {
        let urlString = url // Replace with your API URL
        guard let url = URL(string: urlString) else { return }
        var request = URLRequest(url: url)
           request.httpMethod = "POST"
           request.setValue("application/json", forHTTPHeaderField: "Content-Type") // Set header for JSON
        if(authentication.count != 0){
            let body: [String: Any] = [
                "Authorization":authentication
            ]
            request.httpBody = try? JSONSerialization.data(withJSONObject: body, options: [])
        }
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
           // print(response as Any)
            let jsonResponse = try JSONSerialization.jsonObject(with: data, options: []) as? [String: Any]
            if(jsonResponse!["status"] as? String == "fail"){
                let error = NSError(domain: "fcgapi.olx.in", code: 1001, userInfo: [NSLocalizedDescriptionKey: (jsonResponse?["error"]! as! NSString)])
                completion(.failure(error))
            }
            completion(.success(jsonResponse ?? [:]))
        } catch {
            //print(response.debugDescription as Any)
            completion(.failure(error))
        }
    }
    
    task.resume()
    }

}
