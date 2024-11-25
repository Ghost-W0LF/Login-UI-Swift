//
//  Interceptor.swift
//  Login UI
//
//  Created by Abhinab Khatri on 11/20/24.
//

import Foundation
import Alamofire

final class CustomInterceptor: RequestInterceptor {
//    Add headers or modify requests before they are sent



    func adapt(_ urlRequest: URLRequest, // urlRequest: The URLRequest to adapt.
               for session: Session, // session:The Session that will execute the URLRequest.
               completion: @escaping (Result<URLRequest, Error>) -> Void) // completion: The completion handler that must be called when adaptation is complete.
    {
        var request = urlRequest
        
        request.addValue("Bearer \("Token")", forHTTPHeaderField: "Authorization")
        // Add authorization header
        print("Request adapted: \(request.url?.absoluteString ?? "Nothing here")")
      
        completion(.success(request))
    }
    
    // Retry logic for failed requests
    func retry(_ request: Request, for session: Session, dueTo error: Error, completion: @escaping (RetryResult) -> Void) {
        let responseCode = (request.task?.response as? HTTPURLResponse)?.statusCode
        
        if responseCode == 401 {
            print("Retrying request due to 401 Unauthorized...")
            completion(.retry)
        } else {
            completion(.doNotRetry)
        }
    }
}

