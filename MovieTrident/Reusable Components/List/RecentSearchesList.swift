//
//  RecentSearchesList.swift
//  MovieTrident
//
//  Created by Kalin Balabanov on 13/12/2021.
//

import SwiftUI

struct RecentSearchesList: View {
    
    let movies: [String]
    let action: (String) -> Void
    
    var body: some View {
        ScrollView {
            LazyVStack(spacing: 8) {
                ForEach(movies, id: \.self) { movie in
                    VStack {
                        Button {
                            action(movie)
                        } label: {
                            HStack {
                                Text(movie)
                                Spacer()
                                Image(systemName: "chevron.right")
                                    .padding(.horizontal, 32)
                            }
                        }
                        .foregroundColor(.primary)
                        Divider()
                    }
                }
            }
            .offset(x: 15)
        }
    }
}

//struct RecentSearchesList_Previews: PreviewProvider {
//    static var previews: some View {
//        RecentSearchesList() { }
//    }
//}
