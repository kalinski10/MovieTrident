//
//  MovieListCell.swift
//  MovieTrident
//
//  Created by kalin's personal on 12/12/2021.
//

import SwiftUI

struct MovieListCell: View {
    let movie: MovieSearchImpl
    var body: some View {
        HStack {
            MovieRemoteImage(urlString: movie.poster)
                .frame(width: 50, height: 50)
                .scaledToFit()
            
            Text(movie.title + " - " + movie.year)
        }
    }
}

//struct MovieListCell_Previews: PreviewProvider {
//    static var previews: some View {
//        MovieListCell(url: "")
//    }
//}
