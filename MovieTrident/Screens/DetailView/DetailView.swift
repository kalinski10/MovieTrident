import SwiftUI

struct DetailView: View {
    
    @Environment(\.verticalSizeClass) var verticalSizeClass
    @Environment(\.horizontalSizeClass) var horizontalSizeClass
    
    
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
        if horizontalSizeClass == .regular && verticalSizeClass == .regular {
            content
                .frame(width: 500, height: 800)
        }  else if verticalSizeClass == .compact {
            landscapeContent
        } else {
            content
        }
    }
}

private extension DetailView {
    
    var content: some View {
        GeometryReader { geo in
            
            ZStack(alignment: .top) {
                
                MovieRemoteImage(urlString: movie.poster, cornerRadius: 20)
                    .frame(width: geo.size.width, height: geo.size.height*0.7)
                    .scaledToFill()
                
                if preferredColourScheme == .dark {
                    VStack {
                        Spacer()
                        cardview
                            .offset(x: 0, y: -80)
                            .frame(width: geo.size.width*0.9)
                    }
                }
            }
            .onAppear(perform: showView)
            .overlay(alignment: .top, content: topButtons)
        }
    }
    
    var landscapeContent: some View {
        GeometryReader { geo in
            
            HStack {
                Spacer()
                MovieRemoteImage(urlString: movie.poster, cornerRadius: 20)
                    .frame(height: geo.size.height)
                    .scaledToFit()
                    .overlay(alignment: .topLeading, content: verticalTopButtons)
                
                if preferredColourScheme == .dark {
                    cardview
                        .offset(x: -80, y: 0)
                        .frame(width: geo.size.width*0.3)
                }
                Spacer()
            }
            .onAppear(perform: showView)
        }
    }
    
    var cardview: some View {
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
    
    @ViewBuilder
    func topButtons() -> some View {
        HStack {
            CircularActionButton(imageName: Brand.Icons.chevronLeft, isPrimary: false, action: hideView)
            
            Spacer()
            
            CircularActionButton(imageName:isMovieSaved ? "bookmark.fill" : Brand.Icons.bookmark, isPrimary: false, action: saveMovie)
        }
        .padding(32)
    }
    
    @ViewBuilder
    func verticalTopButtons() -> some View {
        VStack {
            CircularActionButton(imageName: Brand.Icons.chevronLeft, isPrimary: false, action: hideView)
            CircularActionButton(imageName:isMovieSaved ? "bookmark.fill" : Brand.Icons.bookmark, isPrimary: false, action: saveMovie)
        }
        .padding(32)
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
