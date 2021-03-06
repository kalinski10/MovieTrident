import SwiftUI

struct MovieListCell: View {
    
    let movie: MovieSearchImpl
    let action: () -> Void
    
    var body: some View {
        Button(action: action) {
            HStack {
                MovieRemoteImage(urlString: movie.poster)
                    .scaledToFit()
                    .frame(width: 50, height: 50)
                
                Text(movie.title + " - " + movie.year)
                
                Spacer()
                
                Image(systemName: Brand.Icons.chevronRight)
            }
        }
    }
}

struct MovieListCell_Previews: PreviewProvider {
    static var previews: some View {
        MovieListCell(movie: MovieSearchImpl.Mock.dataSet[0]) { }
    }
}
