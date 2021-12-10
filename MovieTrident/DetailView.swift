//
//  DetailView.swift
//  MovieTrident
//
//  Created by kalin's personal on 10/12/2021.
//

import SwiftUI

struct DetailView: View {
    var body: some View {
        ZStack {
            Image("ThorPoster")
                .resizable()
                .frame(width: UIScreen.main.bounds.width, height: UIScreen.main.bounds.height)
                .scaledToFill()
            
            Text("Thor Ragnarok")
                .padding()
                .foregroundColor(.white)
                .background(.ultraThinMaterial)
                .clipShape(RoundedRectangle(cornerRadius: 8))
        }
    }
}

struct DetailView_Previews: PreviewProvider {
    static var previews: some View {
        DetailView()
    }
}
