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
                
                VStack {
                    HStack(spacing: 16) {
                        TextField("Enter a keyword here ", text: $vm.text ) { isEditing in
                            if isEditing {
                                withAnimation {
                                    isFocused = true
                                }
                                
                            } else {
                                withAnimation {
                                    isFocused = false
                                }
                            }
                        }
                        .padding()
                        .frame(height: 50)
                        .background(Color(.systemGray6))
                        .clipShape(Capsule())
                        .focused($isFocused)
                        .onSubmit {
                            Task {
                                await vm.searchMovies()
                            }
                        }
                        
                        CircularActionButton(imageName: isFocused || vm.movies.count != 0 || !vm.text.isEmpty ? "xmark" : "slider.horizontal.3", isPrimary: true) {
                            withAnimation {
                                isFocused = false
                            }
                            vm.text.removeAll()
                            vm.movies.removeAll()
                        }
                        
                    }
                    
                    if isFocused {
                        List {
                            ForEach(0..<5) { _ in
                                Text("Thor Ragnarok")
                                    .onTapGesture {
                                        vm.text = "Thor Ragnarok"
                                        
                                        Task {
                                            await vm.searchMovies()
                                        }
                                        
                                        withAnimation {
                                            isFocused = false
                                        }
                                    }
                            }
                            
                        }
                        .listStyle(.plain)
                        .background(Color.clear)
                    }
                }
                .offset(y: isFocused ? -100 : 0)
                
                Spacer()
                
                // here we will ad the list
                if !isFocused {
                    List {
                        ForEach(vm.movies) { movie in
                            MovieListCell(movie: movie)
                                .onTapGesture(perform: vm.showDetailView)
                        }
                    }
                    .listStyle(.plain)
                }
            }
            .padding(32)
            
            if vm.isShowingDetailView {
                DetailView(isShowing: $vm.isShowingDetailView)
                    .zIndex(2)
                    .transition(.move(edge: .bottom))
            }
            
            if vm.isLoading {
                LoadingView()
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

struct LoadingView: View {
    var body: some View {
        ZStack {
            Color(.systemBackground)
            ProgressView()
                .progressViewStyle(.circular)
        }
    }
}
