import SwiftUI

struct DetailView: View {
    
    @Environment(\.managedObjectContext) var moc
    @FetchRequest(entity: SavedMovie.entity(),
                  sortDescriptors: [])
    var savedMovies: FetchedResults<SavedMovie>
    
    let movie: MovieImpl
    @Binding var isShowing: Bool
    @State private var preferredColourScheme: ColorScheme = .light
    
    private var isMovieSaved: Bool {
        !savedMovies.filter { $0.imdbID == movie.imdbID }.isEmpty
    }
    
    var body: some View {
        ZStack {

            MovieRemoteImage(urlString: movie.poster)
                .frame(maxHeight: .infinity)
                .frame(maxWidth: .infinity)
                .scaledToFill()
                .ignoresSafeArea()
            
            if preferredColourScheme == .dark {
                VStack {
                    
                    HStack {
                        CircularActionButton(imageName: Brand.Icons.chevronLeft, isPrimary: false, action: hideView)
                        
                        Spacer()
                        
                        CircularActionButton(imageName:isMovieSaved ? "bookmark.fill" : Brand.Icons.bookmark, isPrimary: false, action: saveMovie)
                    }
                    
                    Spacer()

                    VStack(alignment: .leading) {
                        
                        Text(movie.title + " - " + movie.year)
                            .font(.title)
                            .bold()
                        
                        Text(movie.genre)

                        Divider()

                        HStack {
                            Label(movie.imdbRating, systemImage: Brand.Icons.star)
                            
                            Spacer()
                            
                            Label(movie.director, systemImage: Brand.Icons.video)
                            
                            Spacer()
                            
                            Label(movie.runtime, systemImage: Brand.Icons.timer)
                        }
                        
                        Text(movie.plot)
                            .multilineTextAlignment(.leading)
                            .padding(.top)

                    }
                    .padding()
                    .foregroundColor(.white)
                    .background(.ultraThinMaterial)
                    .clipShape(RoundedRectangle(cornerRadius: 24))
                    .preferredColorScheme(preferredColourScheme)
                }
                .frame(width: UIScreen.main.bounds.width*0.9)
                .padding(32)
                
            }
        }
        .onAppear(perform: showView)
    }
}

private extension DetailView {
    
    func saveMovie() {
        if isMovieSaved {
            moc.delete(savedMovies.first(where: { $0.imdbID == movie.imdbID })!)
            return
        }
        
        let newFave = SavedMovie(context: self.moc)
        newFave.imdbID = movie.imdbID
        newFave.title = movie.title
        newFave.posterUrl = movie.poster
    }
    
    func hideView() {
        withAnimation {
            isShowing = false
        }
    }
    
    func showView() {
        DispatchQueue.main.asyncAfter(deadline: .now() + 0.3) {
            withAnimation {
                self.preferredColourScheme = .dark
            }
        }
        print(savedMovies)
    }
}

struct DetailView_Previews: PreviewProvider {
    static var previews: some View {
        DetailView(movie: MovieImpl.Mock.data, isShowing: .constant(true))
    }
}
