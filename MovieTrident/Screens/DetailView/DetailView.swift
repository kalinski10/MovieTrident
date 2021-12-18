//
//  DetailView.swift
//  MovieTrident
//
//  Created by kalin's personal on 10/12/2021.
//

import SwiftUI

struct DetailView: View {
    
    let movie: MovieImpl
    @Binding var isShowing: Bool
    @State private var preferredColourScheme: ColorScheme = .light
    
    var body: some View {
        ZStack {
            
            MovieRemoteImage(urlString: movie.poster)
                .frame(maxHeight: .infinity)
                .frame(maxWidth: .infinity)
                .scaledToFill()
                .ignoresSafeArea()
            
            if preferredColourScheme == .dark {
                VStack {
                    
                    HStack {
                        Spacer()
                        CircularActionButton(imageName: Brand.Icons.xmark, isPrimary: false, action: hideView)
                    }
                    
                    Spacer()

                    VStack(alignment: .leading) {
                        
                        Text(movie.title + " - " + movie.year)
                            .font(.title)
                            .bold()
                        
                        Text(movie.genre)

                        Divider()

                        HStack {
                            Label(movie.imdbRating, systemImage: Brand.Icons.star)
                            
                            Spacer()
                            
                            Label(movie.director, systemImage: Brand.Icons.video)
                            
                            Spacer()
                            
                            Label(movie.runtime, systemImage: Brand.Icons.timer)
                        }
                        
                        Text(movie.plot)
                            .multilineTextAlignment(.leading)
                            .padding(.top)

                    }
                    .padding()
                    .foregroundColor(.white)
                    .background(.ultraThinMaterial)
                    .clipShape(RoundedRectangle(cornerRadius: 24))
                    .preferredColorScheme(preferredColourScheme)
                }
                .frame(width: UIScreen.main.bounds.width*0.9)
                .padding(32)
                
            }
        }
        .onAppear(perform: showView)
    }
}

private extension DetailView {
    
    func hideView() {
        withAnimation {
            isShowing = false
        }
    }
    
    func showView() {
        DispatchQueue.main.asyncAfter(deadline: .now() + 0.3) {
            withAnimation {
                self.preferredColourScheme = .dark
            }
        }
    }
}

struct DetailView_Previews: PreviewProvider {
    static var previews: some View {
        DetailView(movie: MovieImpl.Mock.data, isShowing: .constant(true))
    }
}
