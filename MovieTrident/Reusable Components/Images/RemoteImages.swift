import SwiftUI

// acts as a view model to download the image and check if we have one
final class ImageLoader: ObservableObject {
    
    @Published var image: Image? = nil
    private let networkManager = NetworkManagerImpl()
    
    func load(from urlString: String) async {
        let poster = try? await networkManager.downloadImages(from: urlString)
        if let poster = poster {
            DispatchQueue.main.async { [weak self] in
                self?.image =  Image(uiImage: poster)
            }
        }
    }
}

// sets the images as nil initially and if we have an image it downloads it and sets it
struct MovieRemoteImage: View {
    
    @StateObject var imageLoader = ImageLoader()
    
    let urlString: String
    let cornerRadius: CGFloat
    
    init(urlString: String, cornerRadius: CGFloat = 0) {
        self.urlString = urlString
        self.cornerRadius = cornerRadius
    }
    
    var body: some View {
        RemoteImage(image: imageLoader.image)
            .cornerRadius(cornerRadius)
            .task {
                await imageLoader.load(from: urlString)
            }
    }
}

// acts as a secondary component this is essentially either the view or the placeholder
struct RemoteImage: View {
    
    let image: Image?
    
    var body: some View {
        image?.resizable() ?? Image(decorative: Brand.Icons.placeholder).resizable()
    }
}
