//
//  NetworkManager.swift
//  MovieTrident
//
//  Created by kalin's personal on 12/12/2021.
//

import SwiftUI
import Combine

protocol NetworkManagerOutput: AnyObject {
    func fetchMovies(movieSearches: [MovieSearchImpl])
    func error()
}

final class NetworkManager {
    static let shared = NetworkManager()
    
    private init() { }
    
    weak var delegate: NetworkManagerOutput?
    
    private var bag = Set<AnyCancellable>()
    
    private let cache = NSCache<NSString, UIImage>()
    
    private let baseURl = "http://www.omdbapi.com/"
    
    func downloadImages(from urlString: String) async throws -> UIImage? {
        
        let cacheKey = NSString(string: urlString)
        
        if let image = cache.object(forKey: cacheKey) { return image }
        
        guard let url = URL(string: urlString) else { return nil }
        
        let request = URLRequest(url: url)
        
        let (data, _) = try await URLSession.shared.data(for: request)
        
        guard let image = UIImage(data: data) else { return nil }
        
        self.cache.setObject(image, forKey: cacheKey)
        
        return image
    }
    
    
    func getUrl(search: String) throws -> URL {
        let formattedSearch = search.lowercased().replacingOccurrences(of: #"\b "#,
                                                                     with: "+",
                                                                     options: .regularExpression,
                                                                     range: nil)
        guard let url = URL(string: baseURl + "?s=" + formattedSearch + "&apikey=7b11e86d") else { throw MTError.invalidURL }
        
        return url
    }
    
    func loadMovies(from url: URL) async throws {
        
        print(url)
        
        URLSession.shared.dataTaskPublisher(for: url)
            .tryMap { data, response in
                guard let response = response as? HTTPURLResponse, response.statusCode == 200
                else { throw MTError.invalidResponse }
                
                return data
            }
            .decode(type: SearchImpl.self, decoder: JSONDecoder())
            .receive(on: RunLoop.main)
            .sink { [weak self] response in
                switch response {
                case .finished:
                    break
                case .failure(_):
                    self?.delegate?.error()
                }
            }
            receiveValue: { [weak self] search in
                print(search)
                self?.delegate?.fetchMovies(movieSearches: search.result)
            }
            .store(in: &bag)
    }
}
