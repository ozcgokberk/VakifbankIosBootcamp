//
//  Client.swift
//  BreakingBadHw
//
//  Created by Gokberk Ozcan on 23.11.2022.
//

import Foundation

final class Client {
    
    enum Endpoints {
        static let base = "https://www.breakingbadapi.com/api"
//karakteri idye göre çağırmayı daha sonra yapıcam.
        case cast
        case episodes
        case castById(Int)
        case quotes(String)

        var stringValue: String {
            switch self {
            case .cast:
                return Endpoints.base + "/characters"
            case .episodes:
                return Endpoints.base + "/episodes?series=Breaking+Bad"
            case .castById(let id):
                return Endpoints.base + "/api/characters/\(id)"
            case .quotes(let author):
                return Endpoints.base + "/quote?author=\(author)"
            }
        }

        var url: URL {
            return URL(string: stringValue)!
        }
    }

    @discardableResult
    class func taskForGETRequest<ResponseType: Decodable>(url: URL, responseType: ResponseType.Type, completion: @escaping (ResponseType?, Error?) -> Void) -> URLSessionDataTask {
        let task = URLSession.shared.dataTask(with: url) { data, response, error in
            guard let data = data else {
                DispatchQueue.main.async {
                    completion(nil, error)
                }
                return
            }
            let decoder = JSONDecoder()
            do {
                let responseObject = try decoder.decode(ResponseType.self, from: data)
                DispatchQueue.main.async {
                    completion(responseObject, nil)
                }
            } catch {
                do {
                    let errorResponse = try decoder.decode(BaseResponse.self, from: data) as Error
                    DispatchQueue.main.async {
                        completion(nil, errorResponse)
                    }
                } catch {
                    DispatchQueue.main.async {
                        completion(nil, error)
                    }
                }
            }
        }
        task.resume()

        return task
    }

    class func getCast(completion: @escaping ([CastModel]?, Error?) -> Void) {
        taskForGETRequest(url: Endpoints.cast.url, responseType: [CastModel].self) { response, error in
            if let response = response {
                completion(response, nil)
            } else {
                completion(nil, error)
            }
        }
    }

    class func getEpisodes(completion: @escaping ([EpisodesModel]?, Error?) -> Void) {
        taskForGETRequest(url: Endpoints.episodes.url, responseType: [EpisodesModel].self) { response, error in
            if let response = response {
                completion(response, nil)
            } else {
                completion(nil, error)
            }
        }
    }

    class func getCastById(id: Int, completion: @escaping ([CastModel]?, Error?) -> Void) {
        taskForGETRequest(url: Endpoints.castById(id).url, responseType: [CastModel].self) { response, error in
            if let response = response {
                completion(response, nil)
            } else {
                completion(nil, error)
            }
        }
    }
    class func getQuotes(author: String, completion: @escaping ([QuotesModel]?, Error?) -> Void) {
        taskForGETRequest(url: Endpoints.quotes(author).url, responseType: [QuotesModel].self) { response, error in
            if let response = response {
                completion(response, nil)
            } else {
                completion(nil, error)
            }
        }
    }
}

