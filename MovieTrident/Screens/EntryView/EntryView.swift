//
//  ContentView.swift
//  MovieTrident
//
//  Created by kalin's personal on 09/12/2021.
//

import SwiftUI

struct EntryView: View {
    
    @StateObject var vm = EntryVieModel()
    @FocusState private var isFocused: Bool
    let placeHolderText: String = "search"
    
    var body: some View {
        ZStack {
            if vm.movies.isEmpty && !isFocused {
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
            
            VStack {
                HStack {
                    Text("Search for \nany movies here")
                        .font(.largeTitle)
                        .bold()
                        .multilineTextAlignment(.leading)
                    Spacer()
                }
                .blur(radius: isFocused ? 20 : 0)

                HStack(spacing: 16) {
                    TextField("Enter a keyword here ", text: $vm.text ) { isEditing in
                        if isEditing {
                            isFocused = true
                        } else {
                            isFocused = false
                        }
                    }
                        .padding()
                        .frame(height: 50)
                        .background(Color(.systemGray6))
                        .clipShape(Capsule())
                        .focused($isFocused)
                        .onSubmit {
                            Task {
                                do {
                                    let _ = try await vm.fetchMovies()
                                } catch {
                                    print(error)
                                }
                            }
                        }
                    
                    CircularActionButton(imageName: isFocused ? "xmark" : "slider.horizontal.3", isPrimary: true) {
                        isFocused = false
                        vm.text.removeAll()
                        vm.movies.removeAll()
                    }
                }
                
                Spacer()
                
                // here we will ad the list
                List {
                    ForEach(vm.movies) { _ in
                        MovieListCell()
                            .onTapGesture(perform: vm.showDetailView)
                    }
                }
                .listStyle(.plain)
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
