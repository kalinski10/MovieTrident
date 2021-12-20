import SwiftUI

struct ListEmptyState: View {
    
    var body: some View {
        VStack {
            Spacer()
            Group {
                Image(systemName: Brand.Icons.emptyState)
                    .resizable()
                    .scaledToFit()
                    .frame(width: 200, height: 200)
                    .accessibilityHidden(true)
                
                Text("You haven't saved any movies just yet.")
                    .bold()
                    .font(.largeTitle)
                    .padding(.bottom, 32)
            }
            .foregroundColor(Brand.Colour.primary)
            .padding(.horizontal, 32)
        }
    }
}

struct ListEmptyState_Previews: PreviewProvider {
    static var previews: some View {
        ListEmptyState()
    }
}
