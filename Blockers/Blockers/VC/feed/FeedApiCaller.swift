//
//  FeedApiCaller.swift
//  Blockers
//
//  Created by Rohit on 19/06/21.
//

import Foundation

final class FeedApiCaller {
    
    static let shared = FeedApiCaller()
    let now = Date()
    struct  Constants {
       
        static let  topBlockchainURl = URL(string: "https://newsapi.org/v2/everything?q=blockchain&language=en&sortBy=publishedAt&apiKey=6c344dd4fc8047b8a8646a85d59a6869")
    }
    private  init () {
        
    }
    public func getTopFeeds(completion: @escaping (Result<[Article],Error>) -> Void){
        print(now)
        guard let url = Constants.topBlockchainURl else {
            return
        }
        let task = URLSession.shared.dataTask(with: url) {
            data , _, error in
            if let error = error {
                completion(.failure(error))
            }
            else if let data = data {
                do {
                    let result = try JSONDecoder().decode(APIResponse.self, from: data)
                    print("Article: \(result.articles.count)")
                    completion(.success(result.articles))
                }
                catch {
                    completion(.failure(error))
                }
            }
        }
        task.resume()
    }
    
}

struct APIResponse:Codable{
    let articles: [Article]
}

struct Article:Codable {
    let source: Source
    let title: String?
    let description: String?
    let url: String?
    let urlToImage: String?
    let publishedAt: String?
}

struct Source:Codable {
    let name: String?
}
