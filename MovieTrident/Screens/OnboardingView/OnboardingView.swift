import SwiftUI

struct OnboardingView: View {
    
    private let vm = OnboardingViewModel()
    let action: () -> Void
    
    var body: some View {
        VStack {
            Text("Welcome to MovieTrident")
                .bold()
                .font(.largeTitle)
                .padding(32)
                .padding(.top, 32)
            
            Spacer()
            
            VStack(alignment: .leading, spacing: 32) {
                ForEach(vm.onboardingSections) { section in
                    OnboardingSection(section: section)
                }
            }
            .padding(32)
            
            Spacer()
            
            Button(action: action) {
                Text("Continue")
                    .foregroundColor(.white)
                    .frame(maxWidth: .infinity)
                    .frame(height: 50)
                    .background(Brand.Colour.primary)
                    .cornerRadius(8)
            }
            .padding(32)
            .padding(.bottom, 32)
        }
    }
}

struct OnboardingView_Previews: PreviewProvider {
    static var previews: some View {
        OnboardingView() { }
    }
}

// MARK: - Views

fileprivate struct OnboardingSection: View {
    
    let section: OnboardingModel
    
    var body: some View {
        HStack {
            Image(systemName: section.image)
                .resizable()
                .scaledToFit()
                .foregroundColor(Brand.Colour.primary)
                .frame(width: 30, height: 30)
            
            VStack(alignment: .leading) {
                Text(section.title)
                    .foregroundColor(Brand.Colour.primary)
                    .bold()
                
                Text(section.body)
                    .foregroundColor(.secondary)
                    .font(.subheadline)
                
            }
        }
    }
}
