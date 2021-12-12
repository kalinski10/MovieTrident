//
//  ContentView.swift
//  MovieTrident
//
//  Created by kalin's personal on 09/12/2021.
//

import SwiftUI

struct EntryView: View {
    
    @StateObject var vm = EntryVieModel()
    let placeHolderText: String = "search"
    
    var body: some View {
        ZStack {
            // empty state
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
            
            VStack {
                HStack {
                    Text("Search for \nany movies here")
                        .font(.largeTitle)
                        .bold()
                        .multilineTextAlignment(.leading)
                    Spacer()
                }

                HStack(spacing: 16) {
                    TextField("Enter a keyword here ", text: $vm.text)
                        .padding()
                        .frame(height: 50)
                        .background(Color(.systemGray6))
                        .clipShape(Capsule())
                        .onSubmit {
                            Task {
                                do {
                                    let _ = try await vm.fetchMovies()
                                } catch {
                                    print(error)
                                }
                            }
                        }
                    
                    CircularActionButton(imageName: "slider.horizontal.3", isPrimary: true) { }
                }
                
                Spacer()
            }
            .padding(32)
            
            if vm.isShowingDetailView {
                DetailView(isShowing: $vm.isShowingDetailView)
                    .zIndex(2)
                    .transition(.move(edge: .bottom))
            }
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        EntryView()
            .preferredColorScheme(.light)
    }
}
