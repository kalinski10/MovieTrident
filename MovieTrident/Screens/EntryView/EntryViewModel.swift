//
//  EntryViewModel.swift
//  MovieTrident
//
//  Created by kalin's personal on 11/12/2021.
//

import SwiftUI
import Combine

enum CustomError: Error {
    case someError
}

final class EntryVieModel: ObservableObject {
    
    @Published var isShowingDetailView: Bool = false
    @Published var isLoading:           Bool = false
    @Published var text:                String = ""
    @Published var movies:              [MovieSearchImpl] = [] {
        didSet {
            print(movies)
        }
    }
    var bag = Set<AnyCancellable>()
    
    let baseURl = "http://www.omdbapi.com/"
    
    func showDetailView() {
        withAnimation {
            isShowingDetailView = true
        }
    }
    
    func getUrl() throws -> URL {
        let formattedSearch = text.lowercased().replacingOccurrences(of: #"\b "#,
                                                        with: "+",
                                                        options: .regularExpression,
                                                        range: nil)
        guard let url = URL(string: baseURl + "?s=" + formattedSearch + "&apikey=7b11e86d") else { throw CustomError.someError }
        
        return url
        
    }
    
    func fetchMovies() async throws {
        isLoading = true
        
        do {
            let url = try getUrl()
            
            print(url)
            
            URLSession.shared.dataTaskPublisher(for: url)
                .tryMap { data, response in
                    
                    if let response = response as? HTTPURLResponse {
                        print(response.statusCode)
                    }
                    guard
                        let response = response as? HTTPURLResponse,
                        response.statusCode == 200
                    else {
                        throw CustomError.someError
                    }
                    print(data)
                    return data
                }
                .decode(type: SearchImpl.self, decoder: JSONDecoder())
                .sink { [weak self] completion in
                    guard let self = self else { return }
                    switch completion {
                    case .finished:
                        DispatchQueue.main.async {
                            self.isLoading = false
                        }
                    case .failure(let err):
                        print(err)
                    }
                } receiveValue: { [weak self] search in
                    guard let self = self else { return }
                    DispatchQueue.main.async {
                        self.movies = search.result
                    }
                }.store(in: &bag)
            
        } catch {
            print(error)
        }       
    }
}
