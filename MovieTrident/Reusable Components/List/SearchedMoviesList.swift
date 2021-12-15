//
//  SearchedMoviesList.swift
//  MovieTrident
//
//  Created by Kalin Balabanov on 13/12/2021.
//

import SwiftUI

struct SearchedMoviesList: View {
    
    let movies: [MovieSearchImpl]
    let action: (MovieSearchImpl) -> Void
    
    var body: some View {
        List {
            ForEach(movies) { movie in
                MovieListCell(movie: movie) {
                    action(movie)
                }
            }
        }
        .listStyle(.plain)
    }
}

//struct SearchedMoviesList_Previews: PreviewProvider {
//    static var previews: some View {
//        SearchedMoviesList()
//    }
//}
