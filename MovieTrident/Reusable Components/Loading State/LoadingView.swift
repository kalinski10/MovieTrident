//
//  LoadingView.swift
//  MovieTrident
//
//  Created by Kalin Balabanov on 13/12/2021.
//

import SwiftUI

struct LoadingView: View {
    var body: some View {
        ZStack {
            Color(.systemBackground)
            ProgressView()
                .progressViewStyle(.circular)
                .scaleEffect(2)
                .tint(Brand.Colour.primary)
        }
    }
}


struct LoadingView_Previews: PreviewProvider {
    static var previews: some View {
        LoadingView()
    }
}
