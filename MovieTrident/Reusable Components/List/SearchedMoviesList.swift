import SwiftUI

struct SearchedMoviesList: View {
    
    let movies: [MovieSearchImpl]
    let action: (String) -> Void
    
    var body: some View {
        List {
            ForEach(movies) { movie in
                MovieListCell(movie: movie) {
                    action(movie.imdbID)
                }
            }
        }
        .listStyle(.plain)
        .padding(.horizontal, 32)
    }
}

struct SearchedMoviesList_Previews: PreviewProvider {
    static var previews: some View {
        SearchedMoviesList(movies: MovieSearchImpl.Mock.dataSet) { _ in }
    }
}
