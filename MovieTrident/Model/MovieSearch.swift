import Foundation

protocol MovieSearch: Identifiable, Decodable {
    var title:      String { get set }
    var year:       String { get set }
    var poster:     String { get set }
    var imdbID:     String { get set }
    var id:         String { get }
}

extension MovieSearch {
    var id: String { imdbID }
}

struct MovieSearchImpl: MovieSearch {
    var title:  String
    var year:   String
    var poster: String
    var imdbID: String
}

extension MovieSearchImpl {
    enum CodingKeys: String, CodingKey {
        case title      = "Title"
        case year       = "Year"
        case poster     = "Poster"
        case imdbID
    }
}

// MARK: - Mock

extension MovieSearchImpl {
    enum Mock { }
}

extension MovieSearchImpl.Mock {
    static let dataSet: [MovieSearchImpl] = [.init(title: "Thor Ragnarok",
                                                   year: "2017",
                                                   poster: "",
                                                   imdbID: "1234")]
}
