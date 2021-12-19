import Foundation

protocol Onboarding: Identifiable {
    var id:     UUID { get }
    var image:  String { get }
    var title:  String { get }
    var body:   String { get }
}

struct OnboardingModel: Onboarding {
    let id =    UUID()
    let image:  String
    let title:  String
    let body:   String
}

struct OnboardingViewModel {
    let onboardingSections: [OnboardingModel] = [.init(image: Brand.Icons.magnifyingglass,
                                                       title: "Expansive Search",
                                                       body: "You can search for any movies, series or even episodes"),
                                                 .init(image: Brand.Icons.settings,
                                                       title: "Filters!",
                                                       body: "You can also filter your search by year and type."),
                                                 .init(image: Brand.Icons.star,
                                                       title: "Save Movies",
                                                       body: "Finally, you can save your favourite movies.")]
}
