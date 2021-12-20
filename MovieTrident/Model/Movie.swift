import Foundation

protocol Movie: Identifiable, Decodable {
    var title:      String { get set }
    var year:       String { get set }
    var runtime:    String { get set }
    var genre:      String { get set }
    var director:   String { get set }
    var plot:       String { get set }
    var poster:     String { get set }
    var imdbRating: String { get set }
    var imdbID:     String { get set }
    var id:         String { get }
}

extension Movie {
    var id: String { imdbID }
}

// MARK: - Implemetation

struct MovieImpl: Movie {
    var title:      String
    var year:       String
    var runtime:    String
    var genre:      String
    var director:   String
    var plot:       String
    var poster:     String
    var imdbRating: String
    var imdbID:     String
}

extension MovieImpl {
    enum CodingKeys: String, CodingKey {
        case title      = "Title"
        case year       = "Year"
        case runtime    = "Runtime"
        case genre      = "Genre"
        case director   = "Director"
        case plot       = "Plot"
        case poster     = "Poster"
        case imdbRating
        case imdbID
    }
}


// MARK: - Mock

extension MovieImpl {
    enum Mock { }
}

extension MovieImpl.Mock {
    static let data = MovieImpl(title: "Thor Ragnarock",
                                year: "2017",
                                runtime: "130",
                                genre: "Action, Comedy, Adventure",
                                director: "Taika Waititi",
                                plot: "Imprisoned on the planet Sakaar, Thor must race against time to return to Asgard and stop Ragnarök, the destruction of his world, at the hands of the powerful and ruthless Hela.",
                                poster: "",
                                imdbRating: "7.9",
                                imdbID: "1234")
}
