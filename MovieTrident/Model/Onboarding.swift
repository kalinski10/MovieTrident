import Foundation

protocol Onboarding: Identifiable {
    var id:     UUID { get }
    var image:  String { get }
    var title:  String { get }
    var body:   String { get }
}

// MARK: - Implemetation

struct OnboardingModel: Onboarding {
    let id =    UUID()
    let image:  String
    let title:  String
    let body:   String
}
