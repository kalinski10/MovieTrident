//
//  ListEmptyState.swift
//  MovieTrident
//
//  Created by Kalin Balabanov on 13/12/2021.
//

import SwiftUI

struct ListEmptyState: View {
    var body: some View {
        VStack {
            Spacer()
            Image(systemName: "list.and.film")
                .resizable()
                .scaledToFit()
                .frame(width: 200, height: 200)
            
            Text("You haven't searched for any movies just yet")
                .bold()
                .font(.largeTitle)
        }
        .foregroundColor(Brand.Colour.primary)
        .padding(32)
    }
}

struct ListEmptyState_Previews: PreviewProvider {
    static var previews: some View {
        ListEmptyState()
    }
}
