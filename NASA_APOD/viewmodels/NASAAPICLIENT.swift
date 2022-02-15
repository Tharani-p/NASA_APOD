//
//  NASA_API_CLIENT.swift
//  NASA_APOD
//
//  Created by Tharani on 15/02/22.
//

import Foundation
import UIKit

class NASAAPIClient {
    
    static func getDataFromAPI(with completion: @escaping (NASAModel) -> ()) {
        let urlString = "https://api.nasa.gov/planetary/apod?api_key=8DJNEM7TLJhlbOzaiN7bUmfNW0eghKtPVKbJOO9e"
        let url = URL(string: urlString)
        guard let unwrappedURL = url else {return}
        
        let session = URLSession.shared
        let task = session.dataTask(with: unwrappedURL) { (data, response, error) in
            
            print("Start")
            guard let _ = data else {return}
            
            do {
                let result = try? JSONDecoder().decode(NASAModel.self, from: data!)
                if let aResult = result {
                    completion(aResult)
                }
                print("got data")
                
            } catch {
        
                print(error)
                
            }
            
        }
        task.resume()
        
    }
    
   static func downloadImage(at urlString: String, completion: @escaping (Bool, UIImage?, Data?) -> ()) {
        
        let url = URL(string: urlString)
        guard let unwrappedURL = url else {return}
    
        let request = URLRequest(url: unwrappedURL)
        
        let session = URLSession.shared
        
        let task = session.dataTask(with: request) { data, response, error in
            
            guard let data = data, let image = UIImage(data: data) else { completion(false, nil, nil)
                return }
    
           completion(true, image, data)
        
        }
        task.resume()
    }

}








