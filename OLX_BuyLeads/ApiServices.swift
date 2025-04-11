//
//  ApiServices.swift
//  CTE_BuyLeads
//
//  Created by Aruna on 25/03/25.
//

import Foundation



public class ApiServices {
    
    enum APIError: Error {
        case invalidURL
        case requestFailed(statusCode: Int)
        case requestFailedwithresponse(response: String)
        case noData
        case decodingError
        case other(Error)
    }
    
    public init() {} // Required for external usage
     func sendRawDataWithHeaders(parameters: [String: Any], headers: [String: String],url : String,authentication: String, completion: @escaping (Result<[String: Any], APIError>) -> Void) {
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
               completion(.failure(.other(error)))
               return
           }
        let task = URLSession.shared.dataTask(with: request) { data, response, error in
        if let error = error {
            completion(.failure(.other(error)))
            return
        }
        guard let data = data else {
            completion(.failure(.noData))
            return
        }
        do {
            let httpResponse = response as? HTTPURLResponse
            if(httpResponse!.statusCode == 200 || httpResponse?.statusCode == 403){
               let jsonResponse = try JSONSerialization.jsonObject(with: data, options: []) as? [String: Any]
               completion(.success(jsonResponse ?? [:]))
               }
            else{
                let message = HTTPURLResponse.localizedString(forStatusCode: httpResponse!.statusCode)
                completion(.failure(.requestFailedwithresponse(response: message)))
            }
        } catch {
            //print(response.debugDescription as Any)
            completion(.failure(.other(error)))
        }
    }
    
    task.resume()
    }
    func fetchdatawithGETAPI(headers: [String: String],url : String,authentication: String, completion: @escaping (Result<[String: Any], APIError>) -> Void) {
       let urlString = url // Replace with your API URL
       guard let url = URL(string: urlString) else { return }
       var request = URLRequest(url: url)
          request.httpMethod = "GET"
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
//          do {
//              request.httpBody = try JSONSerialization.data(withJSONObject: parameters, options: [])
//          } catch {
//              completion(.failure(.other(error)))
//              return
//          }
       let task = URLSession.shared.dataTask(with: request) { data, response, error in
       if let error = error {
           completion(.failure(.other(error)))
           return
       }
       guard let data = data else {
           completion(.failure(.noData))
           return
       }
       do {
           let httpResponse = response as? HTTPURLResponse
           if(httpResponse!.statusCode == 200 || httpResponse?.statusCode == 403){
              let jsonResponse = try JSONSerialization.jsonObject(with: data, options: []) as? [String: Any]
              completion(.success(jsonResponse ?? [:]))
              }
           else{
               let message = HTTPURLResponse.localizedString(forStatusCode: httpResponse!.statusCode)
               completion(.failure(.requestFailedwithresponse(response: message)))
           }
       } catch {
           //print(response.debugDescription as Any)
           completion(.failure(.other(error)))
       }
   }
   
   task.resume()
   }

}
