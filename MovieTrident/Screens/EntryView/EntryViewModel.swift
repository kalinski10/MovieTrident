//
//  EntryViewModel.swift
//  MovieTrident
//
//  Created by kalin's personal on 11/12/2021.
//

import SwiftUI

final class EntryVieModel: ObservableObject {
    
    @Published var isShowingDetailView: Bool = false
    @Published var isLoading:           Bool = false
    @Published var text:                String = ""
    @Published var movies:              [MovieSearchImpl] = []
    
    let session = NetworkManager.shared
    
    init() {
        session.delegate = self
    }
    
    func showDetailView() {
        withAnimation {
            isShowingDetailView = true
        }
    }
    
    func searchMovies() async {
        isLoading = true
        do {
            let url = try session.getUrl(search: text)
            try await session.loadMovies(from: url)
        } catch {
            print(error)
        }
    }
}

//MARK: - NetworkManagerOutput
extension EntryVieModel: NetworkManagerOutput {
    func fetchMovies(movieSearches: [MovieSearchImpl]) {
        movies = movieSearches
        isLoading = false
    }
    
    func error() {
        isLoading = false
    }
}
