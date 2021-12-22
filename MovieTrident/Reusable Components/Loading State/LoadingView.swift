import SwiftUI

struct LoadingView: View {
    var body: some View {
        ZStack {
            Color(.systemBackground)
            
            ProgressView()
                .progressViewStyle(.circular)
                .scaleEffect(2)
                .tint(Brand.Colour.primary)
        }
        .ignoresSafeArea()
    }
}


struct LoadingView_Previews: PreviewProvider {
    static var previews: some View {
        LoadingView()
    }
}
