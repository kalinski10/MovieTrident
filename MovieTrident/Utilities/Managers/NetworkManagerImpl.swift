import SwiftUI
import Combine

protocol NetworkManagerOutput: AnyObject {
    func fetchMovies(movieSearches: [MovieSearchImpl])
    func fetch(movie: MovieImpl)
    func error()
}

protocol NetworkManager {
    
    var delegate: NetworkManagerOutput? { get set }
    var bag: Set<AnyCancellable> { get set }
    var cache: NSCache<NSString, UIImage> { get }
    
    func downloadImages(from urlString: String) async throws -> UIImage?
    func getUrl(search: String, type: String, year: String) throws -> URL
    func getUrl(id: String) throws -> URL
    func loadMovies(from url: URL) async throws
    func loadMovie(from url: URL) async throws
}

final class NetworkManagerImpl: NetworkManager {
    
    weak var delegate: NetworkManagerOutput?
    
    var bag = Set<AnyCancellable>()
    var cache = NSCache<NSString, UIImage>()
        
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
    
    
    func getUrl(search: String, type: String, year: String) throws -> URL {
        let formattedSearch = search
                                .lowercased()
                                .replacingOccurrences(of: #"\b "#,
                                                      with: "+",
                                                      options: .regularExpression,
                                                      range: nil)
        
        guard let url = URL(string: Base.url +
                                    "?s=" +
                                    formattedSearch +
                                    "&type=\(type)" +
                                    "&y=\(year)" +
                                    "&apikey=7b11e86d")
        else { throw MTError.invalidURL }
        
        return url
    }
    
    func getUrl(id: String) throws -> URL {
        guard let url = URL(string: Base.url +
                            "?i=" + id +
                            "&apikey=7b11e86d")
        else { throw MTError.invalidURL }
        
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
    
    func loadMovie(from url: URL) async throws {
        
        print(url)
        
        URLSession.shared.dataTaskPublisher(for: url)
            .tryMap { data, response in
                guard let response = response as? HTTPURLResponse, response.statusCode == 200
                else { throw MTError.invalidResponse }
                
                return data
            }
            .decode(type: MovieImpl.self, decoder: JSONDecoder())
            .receive(on: RunLoop.main)
            .sink { [weak self] response in
                switch response {
                case .finished:
                    break
                case .failure(_):
                    self?.delegate?.error()
                }
            }
            receiveValue: { [weak self] movie in
                print(movie)
                self?.delegate?.fetch(movie: movie)
            }
            .store(in: &bag)
    }
}
