//
//  NetworkManager.swift
//  FoodyCook
//
//  Created by auriga on 6/27/21.
//

import Foundation
import Alamofire
import Kingfisher

enum APIAddress:String {
    case random = "https://www.themealdb.com/api/json/v1/1/random.php"
    case WithId = "https://www.themealdb.com/api/json/v1/1/lookup.php?i="
    case WithName = "https://www.themealdb.com/api/json/v1/1/search.php?s="
}

class NetworkManager{
    
    class func makeRequest(forStringUrl urlString:String, completionHandler: @escaping (Result<Data?, Error>) -> Void)  {
        if !NetworkReachabilityManager()!.isReachable {
            return completionHandler(.failure(NSError.init(domain: "Network Error", code: 0, userInfo: [:])))
            
        }
        AF.request(urlString)
            .validate(statusCode: 200..<300)
            .responseJSON { response in
                switch response.result {
                case .success(let value):
                    completionHandler(.success(response.data))
                case let .failure(error):
                    completionHandler(.failure(error))
                }
            }
    }
}
extension UIImageView {
    func setKFImage(strUrl:String) {
        let url = URL(string: strUrl)
        self.kf.setImage(with: url)
    }
}
