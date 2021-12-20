import Foundation

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
