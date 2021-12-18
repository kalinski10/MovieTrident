//
//  ContentView.swift
//  MovieTrident
//
//  Created by kalin's personal on 09/12/2021.
//

import SwiftUI

struct EntryView: View {
    
    @Environment(\.managedObjectContext) var moc
    @FetchRequest(entity: MovieTitle.entity(), sortDescriptors: []) var recentSearches: FetchedResults<MovieTitle>
    
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
                    
                    entryField
                    
                    Spacer()
                    
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
                        .transition(.slide)
                        .zIndex(2) // to stay on top of all the content when transitioning
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
    
    var entryField: some View {
        VStack {
            HStack(spacing: 16) {
                MTTextfield(searchInput: $vm.text, isFocused: _isFocused) {
                    saveSearch()
                    Task {
                        await vm.searchMovies()
                    }
                }
                
                CircularActionButton(imageName: shouldShowXmark ? Brand.Icons.xmark : Brand.Icons.settings,
                                     isPrimary: true,
                                     action: handleButtonInput)
                
            }
            .padding(.horizontal, 32)
            
            if shouldShowForm {
                QueryForm(vm: vm)
                    .transition(.slide)
            }
            
            if isFocused {
                RecentSearchesList() { title in
                    recentSearchesInput(from: title)
                }
                .padding(.top, 8)
                .padding(.horizontal, 32)
            }
        }
        .offset(y: focusAnimation ? -80 : 0)
    }
}

// MARK: - Private Methods

private extension EntryView {
    
    func saveSearch() {
        let newSearch = MovieTitle(context: self.moc)
        newSearch.id = UUID()
        newSearch.title = vm.text
    }
    
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
