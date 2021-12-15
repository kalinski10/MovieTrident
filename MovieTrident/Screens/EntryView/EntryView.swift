//
//  ContentView.swift
//  MovieTrident
//
//  Created by kalin's personal on 09/12/2021.
//

import SwiftUI

struct EntryView: View {
    
    @StateObject private var vm = EntryVieModel()
    
    @FocusState private var isFocused: Bool
    @State private var focusAnimation: Bool = false
    
    private var shouldShowForm: Bool { !isFocused && vm.isShowingForm }
    private var shouldShowEmptyState: Bool { vm.movies.isEmpty && !isFocused && !shouldShowForm }
    private var shouldShowXmark: Bool { isFocused || vm.movies.count != 0 || !vm.text.isEmpty }
    
    var body: some View {
        NavigationView {
            ZStack {
                
                if shouldShowEmptyState {
                    ListEmptyState()
                }
                
                VStack {
                    
                    titleView
                        .padding([.horizontal, .top], 32)
                    
                    VStack {
                        HStack(spacing: 16) {
                            MTTextfield(searchInput: $vm.text, isFocused: _isFocused) {
                                Task {
                                    await vm.searchMovies()
                                }
                            }
                            
                            CircularActionButton(imageName: shouldShowXmark ? "xmark" : "slider.horizontal.3",
                                                 isPrimary: true,
                                                 action: handleButtonInput)
                            
                        }
                        .padding(.horizontal, 32)
                        
                        if shouldShowForm {
                            List {
                                Picker("Type", selection: $vm.type) {
                                    ForEach(vm.movieTypes, id: \.self) {
                                        Text($0)
                                    }
                                }
                                
                                Picker("Year", selection: $vm.year) {
                                    ForEach(vm.years.reversed(), id: \.self) {
                                        Text($0)
                                    }
                                }
                                
                            }
                            .frame(height: 160)
                            .transition(.slide)
                        }
                        
                        if isFocused {
                            RecentSearchesList(movies: vm.recentSearches) { title in
                                recentSearchesInput(from: title)
                            }
                            .padding(.top, 8)
                            .padding(.horizontal, 32)
                        }
                    }
                    .offset(y: focusAnimation ? -100 : 0)
                    
                    Spacer()
                    
                    // here we will ad the list
                    if !isFocused {
                        SearchedMoviesList(movies: vm.movies) { movie in
                            Task {
                                await vm.showDetailView(with: movie.imdbID)
                            }
                        }
                        .padding(.horizontal, 32)
                    }
                }
                
                
                if vm.isShowingDetailView {
                    DetailView(movie: vm.movie, isShowing: $vm.isShowingDetailView)
                        .zIndex(2)
                        .transition(.slide)
                }
                
                if vm.isLoading {
                    LoadingView()
                }
            }
            .navigationBarHidden(true)
        }
        .accentColor(Brand.Colour.primary)
        .onChange(of: isFocused, perform: animateFocusState)
    }
}

// MARK: - Views

private extension EntryView {
    
    var titleView: some View {
        HStack {
            Text("Search for \nany movies here")
                .font(.largeTitle)
                .bold()
                .multilineTextAlignment(.leading)
            Spacer()
        }
        .blur(radius: isFocused ? 20 : 0)
    }
}

// MARK: - Private Methods

private extension EntryView {
    
    func animateFocusState(_ state: Bool) {
        withAnimation {
            focusAnimation.toggle()
        }
    }
    
    func recentSearchesInput(from title: String) {
        vm.text = title
        
        Task {
            await vm.searchMovies()
        }
        
        isFocused = false
    }
    
    func handleButtonInput() {
        if !isFocused && vm.text.isEmpty {
            withAnimation {
                vm.isShowingForm.toggle()
            }
        } else {
            isFocused = false
            vm.text.removeAll()
            vm.movies.removeAll()
        }
    }
}

// MARK: - Preview

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        EntryView()
            .preferredColorScheme(.light)
    }
}
