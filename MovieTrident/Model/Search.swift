import Foundation

protocol Search: Decodable {
    associatedtype Result = MovieSearch
    var result: [Result] { get set }
    var totalResults: String { get set }
}

struct SearchImpl: Search {
    var result: [MovieSearchImpl]
    var totalResults: String
}

extension SearchImpl {
    enum CodingKeys: String, CodingKey {
        case result = "Search"
        case totalResults
    }
}

// MARK: - Mock

extension SearchImpl {
    enum Mock { }
}

extension SearchImpl.Mock {
    static let data = SearchImpl(result: MovieSearchImpl.Mock.dataSet,
                                 totalResults: String(MovieSearchImpl.Mock.dataSet.count))
}
