//
//  MovieListCell.swift
//  MovieTrident
//
//  Created by kalin's personal on 12/12/2021.
//

import SwiftUI

struct MovieListCell: View {
    var body: some View {
        HStack {
            Image("ThorPoster")
                .resizable()
                .frame(width: 50, height: 50)
                .scaledToFit()
            
            Text("Thor Ragnarock" + " - " + "2017")
        }
    }
}

struct MovieListCell_Previews: PreviewProvider {
    static var previews: some View {
        MovieListCell()
    }
}
