import SwiftUI

final class EntryViewModelImpl: EntryViewModel {
    
    @AppStorage("didShowOnboarding") var didShowOnboarding: Bool = false
    
    @Published var isShowingForm: Bool = false
    @Published var isShowingDetailView: Bool = false
    @Published var isLoading: Bool = false
    @Published var focusAnimation: Bool = false
    @Published var isShowingOnboarding: Bool = false
    
    @Published var text: String = ""
    @Published var type: String = ""
    @Published var year: String = ""
    
    @Published var movies: [MovieSearchImpl] = []
    @Published var movie: MovieImpl = MovieImpl.Mock.data
    
    var session = NetworkManagerImpl()

    let movieTypes = ["movie", "series", "episode"]
    var years: [String] = []
    
    init() {
        session.delegate = self
        generateDates()
    }
    
    func showDetailView(with Id: String) {
        isLoading = true
        
        do {
            let url = try session.getUrl(id: Id)
            try session.loadMovie(from: url)
        } catch {
            print(error)
        }
    }
    
    func searchMovies() {
        
        isLoading = true
        
        do {
            let url = try session.getUrl(search: text, type: type, year: year)
            try session.loadMovies(from: url)
        } catch {
            print(error)
        }
        
        isShowingForm = false
    }
    
    func animateFocusState(_ state: Bool) {
        withAnimation {
            focusAnimation = state
        }
    }
    
    func generateDates() {
        let y = Array(1900...2022)
        y.forEach { years.append(String($0))}
    }
    
    func shouldShowOnboarding() {
        if !didShowOnboarding {
            isShowingOnboarding = true
        }
    }
    
    func onboardingFinished() {
        isShowingOnboarding = false
        didShowOnboarding = true
    }
}

//MARK: - NetworkManagerOutput

extension EntryViewModelImpl: NetworkManagerOutput {
    func fetch(movie: MovieImpl) {
        self.movie = movie
        
        withAnimation {
            isShowingDetailView = true
        }
        
        isLoading = false

    }
    
    func fetchMovies(movieSearches: [MovieSearchImpl]) {
        movies = movieSearches
        isLoading = false
    }
    
    func error() {
        isLoading = false
    }
}
