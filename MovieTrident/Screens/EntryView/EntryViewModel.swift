//
//  EntryViewModel.swift
//  MovieTrident
//
//  Created by kalin's personal on 11/12/2021.
//

import SwiftUI

final class EntryVieModel: ObservableObject {
    
    @Published var isShowingForm:       Bool = false
    @Published var isShowingDetailView: Bool = false
    @Published var isLoading:           Bool = false
    
    @Published var text:                String = ""
    @Published var type:                String = ""
    @Published var year:                String = ""
    
    @Published var recentSearches:      [String] = []
    @Published var movies:              [MovieSearchImpl] = []
    @Published var movie:               MovieImpl = .init(title: "Thor Ragnarock",
                                                          year: "2017",
                                                          runtime: "130",
                                                          genre: "Action, Comedy, Adventure",
                                                          director: "Taika Waititi",
                                                          plot: "Imprisoned on the planet Sakaar, Thor must race against time to return to Asgard and stop Ragnarök, the destruction of his world, at the hands of the powerful and ruthless Hela.",
                                                          poster: "",
                                                          imdbRating: "7.9",
                                                          imdbID: "1234")

    var movieTypes = ["movie", "series", "episode"]
    var years: [String] = []
    
    private let session = NetworkManager.shared
    
    init() {
        session.delegate = self
        generateDates()
    }
    
    func showDetailView(with Id: String) async {
        isLoading = true
        do {
            let url = try session.getUrl(id: Id)
            try await session.loadMovie(from: url)
        } catch {
            print(error)
        }
    }
    
    func searchMovies() async {
        isLoading = true
        recentSearches.append(text)
        do {
            let url = try session.getUrl(search: text, type: type, year: year)
            try await session.loadMovies(from: url)
        } catch {
            print(error)
        }
        isShowingForm = false
    }
    
    private func generateDates() {
        let y = Array(1900...2022)
        y.forEach { years.append(String($0))}
    }
}

//MARK: - NetworkManagerOutput
extension EntryVieModel: NetworkManagerOutput {
    func fetch(movie: MovieImpl) {
        self.movie = movie
        
        withAnimation {
            isShowingDetailView = true
        }
        
        isLoading = false

    }
    
    func fetchMovies(movieSearches: [MovieSearchImpl]) {
        movies = movieSearches
        isLoading = false
    }
    
    func error() {
        isLoading = false
    }
}
