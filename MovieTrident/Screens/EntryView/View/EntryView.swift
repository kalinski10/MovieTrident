import SwiftUI

struct EntryView: View {
    
    @Environment(\.verticalSizeClass) var verticalSizeClass
    @Environment(\.managedObjectContext) var moc
    
    @FetchRequest(entity: MovieTitle.entity(),
                  sortDescriptors: [])
    var recentSearches: FetchedResults<MovieTitle>
    @FetchRequest(entity: SavedMovie.entity(),
                  sortDescriptors: [])
    var savedMovies: FetchedResults<SavedMovie>
    
    @StateObject private var vm = EntryViewModelImpl()
    @FocusState private var isFocused: Bool
    
    private var shouldShowForm: Bool { !isFocused && vm.isShowingForm }
    private var shouldShowEmptyState: Bool { vm.movies.isEmpty && !isFocused && !shouldShowForm && savedMovies.isEmpty}
    private var shouldShowXmark: Bool { isFocused || vm.movies.count != 0 || !vm.text.isEmpty }
    private var shouldShowSearchedList: Bool { !isFocused && !vm.movies.isEmpty }
    private var shouldShowSavedList: Bool { !savedMovies.isEmpty && vm.movies.isEmpty && !isFocused }
    
    var body: some View {
        ZStack {
            if verticalSizeClass == .compact {
                HStack {
                    VStack {
                        titleView
                        
                        entryField
                        
                        Spacer()
                        
                        if shouldShowSearchedList {
                            SearchedMoviesList(movies: vm.movies, action: vm.showDetailView(with: ))
                        }
                    }
                    
                    if shouldShowSavedList {
                        savedList
                    }
                    
                    if shouldShowEmptyState {
                        ListEmptyState()
                    }
                }
                .blur(radius:  vm.isShowingDetailView ? 20 : 0)
                .disabled(vm.isShowingDetailView ? true : false)
                
            } else {
                VStack {
                    
                    titleView
                    
                    entryField
                    
                    if shouldShowSearchedList {
                        SearchedMoviesList(movies: vm.movies, action: vm.showDetailView(with: ))
                    }
                    
                    if shouldShowSavedList { savedList }
                    
                    if shouldShowEmptyState {
                        Spacer()
                        ListEmptyState()
                    }
                }
                .blur(radius: vm.isShowingDetailView ? 20 : 0)
                .disabled(vm.isShowingDetailView ? true : false)
            }
            
            if vm.isShowingDetailView {
                DetailView(movie: vm.movie, isShowing: $vm.isShowingDetailView)
                    .transition(.move(edge: .bottom))
                    .zIndex(2) // to stay on top of all the content when transitioning
            }
            
            if vm.isLoading {
                LoadingView()
            }
            
        }
        .accentColor(Brand.Colour.primary)
        .onAppear(perform: vm.shouldShowOnboarding)
        .onChange(of: isFocused, perform: vm.animateFocusState)
        .sheet(isPresented: $vm.isShowingOnboarding, onDismiss: vm.onboardingFinished) {
            OnboardingView() {
                vm.isShowingOnboarding = false
            }
        }
        
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
        .padding([.horizontal, .top], 32)
    }
    
    var entryField: some View {
        VStack {
            HStack(spacing: 16) {
                MTTextfield(searchInput: $vm.text, isFocused: _isFocused) {
                    guard !vm.text.isEmpty else { return }
                    
                    saveSearch()
                    vm.searchMovies()
                }
                
                CircularActionButton(imageName: shouldShowXmark ? Brand.Icons.xmark : Brand.Icons.settings,
                                     isPrimary: true,
                                     action: handleButtonInput)
                
            }
            .padding(.horizontal, 32)
            
            if shouldShowForm {
                QueryForm(vm: vm)
                    .transition(.move(edge: .leading))
                Spacer()
            }
            
            if isFocused {
                RecentSearchesList() { title in
                    recentSearchesInput(from: title)
                }
                .padding(.top, 8)
                .padding(.horizontal, 32)
            }
        }
        .offset(y: vm.focusAnimation ? -80 : 0)
    }
    
    var savedList: some View {
        GeometryReader { geo in
            ScrollView(.horizontal, showsIndicators: false) {
                LazyHStack {
                    ForEach(savedMovies) { movie in
                        if let url = movie.posterUrl {
                            MovieRemoteImage(urlString: url, cornerRadius: 16)
                                .scaledToFit()
                                .frame(height: geo.size.height*0.8)
                                .padding([.leading, .vertical], 32)
                                .cornerRadius(20)
                                .onTapGesture {
                                    vm.showDetailView(with: movie.imdbID ?? "")
                                }
                        }
                    }
                }
            }
        }
    }
}

// MARK: - Private Methods

private extension EntryView {
    
    func saveSearch() {
        let newSearch = MovieTitle(context: self.moc)
        newSearch.id = UUID()
        newSearch.title = vm.text
    }
    
    func recentSearchesInput(from title: String) {
        vm.text = title
        
        vm.searchMovies()
        
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
