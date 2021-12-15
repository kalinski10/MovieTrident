//
//  RemoteImages.swift
//  MovieTrident
//
//  Created by kalin's personal on 12/12/2021.
//

import SwiftUI

// acts as a view model to download the image and check if we have one
final class ImageLoader: ObservableObject {
    
    @Published var image: Image? = nil
    
    func load(from urlString: String) async {
        let poster = try? await NetworkManager.shared.downloadImages(from: urlString)
        if let poster = poster {
            DispatchQueue.main.async { [weak self] in
                self?.image =  Image(uiImage: poster)
            }
        }
    }
}

// acts as a secondary component this is essentially either the view or the placeholder
struct RemoteImage: View {
    
    let image: Image?
    
    var body: some View {
        image?.resizable() ?? Image("ThorPoster").resizable()
    }
}

// sets the images as nil initially and if we have an image it downloads it and sets it
struct MovieRemoteImage: View {
    
    @StateObject var imageLoader = ImageLoader()
    
    var urlString: String
    
    var body: some View {
        RemoteImage(image: imageLoader.image)
            .onAppear {
                Task {
                    await imageLoader.load(from: urlString)
                }
            }
    }
}
