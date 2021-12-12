//
//  Movie.swift
//  MovieTrident
//
//  Created by kalin's personal on 11/12/2021.
//

import Foundation

// MARK: - Search

protocol Search: Decodable {
    var result:       [MovieSearchImpl] { get set }
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

// MARK: - MovieSeach
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

// MARK: - MovieSeach

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
