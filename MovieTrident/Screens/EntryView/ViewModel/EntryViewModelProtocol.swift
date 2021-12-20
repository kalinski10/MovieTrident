import Foundation

protocol EntryViewModel: ObservableObject {
    
    /// State property chechking wether the query form is present
    var isShowingForm: Bool { get set }
    
    /// State property chechking wether the selected movie detail view is present
    var isShowingDetailView: Bool { get set }
    
    /// State property chechking wether the loading view is present
    var isLoading: Bool { get set }
    
    /// State property chechking wether the textfield if focused and allowing us to create animation
    var focusAnimation: Bool { get set}
    
    /// State property chechking wether the onboarding is currenlty showing
    var isShowingOnboarding: Bool { get set}
    
    /// State property keeping reference to the title of the movie searched
    var text: String { get set }
    
    /// State property keeping reference to the type
    /// options inlcude: Movies, Series, Epsiodes
    var type: String { get set }
    
    /// State property keeping reference to the year the movie was released
    var year: String { get set }
    
    /// A list of Movies from the current search
    var movies: [MovieSearchImpl] { get set }
    
    /// The movie we want to show display more information on
    var movie: MovieImpl { get set }
    
    /// Session Manager taking care of all requests
    var session: NetworkManagerImpl { get }
    
    /// Asynchronous function that takes in the imbdID of the selected movie and present the detail view
    func showDetailView(with Id: String)
    
    /// Asynchronous function that returns the first 10 movies of the current search
    func searchMovies()
    
    /// generates dates from 1900 - current year to populate the query form
    func generateDates()
    
    /// updates the state of the focusedAnimation state property based on if the textfield is focused
    func animateFocusState(_ state: Bool)
    
    /// checks wether the onboarding process should be shown
    func shouldShowOnboarding()
    
    /// A function that marks the onboarding process as finished
    func onboardingFinished()
}
