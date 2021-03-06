import SwiftUI

struct CircularActionButton: View {
    
    let imageName: String
    let isPrimary: Bool
    let action: () -> Void
    
    var body: some View {
        Button(action: action) {
            Image(systemName: imageName)
                .resizable()
                .scaledToFit()
                .frame(width: 20, height: 20)
                .padding()
                .foregroundColor(.white)
                .background(getBackground())
        }
    }
}

private extension CircularActionButton {
    
    @ViewBuilder
    func getBackground() -> some View {
        if isPrimary {
            Circle()
                .foregroundColor(Brand.Colour.primary)
        } else {
            Circle()
                .foregroundColor(.clear)
                .background(.ultraThinMaterial)
                .clipShape(Circle())
        }
    }
}


struct CircularActionButton_Previews: PreviewProvider {
    static var previews: some View {
        CircularActionButton(imageName: "slider.horizontal.3", isPrimary: true) { }
    }
}
