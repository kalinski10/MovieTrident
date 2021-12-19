import SwiftUI

struct RecentSearchesList: View {
    
    @Environment(\.managedObjectContext) var moc
    @FetchRequest(entity: MovieTitle.entity(), sortDescriptors: []) var recentSearches: FetchedResults<MovieTitle>
    let action: (String) -> Void
    
    var body: some View {
        ScrollView {
            LazyVStack(spacing: 8) {
                ForEach(recentSearches) { movie in
                    VStack {
                        Button {
                            action(movie.title ?? "")
                        } label: {
                            HStack {
                                Text(movie.title ?? "")
                                Spacer()
                                Image(systemName: Brand.Icons.chevronRight)
                                    .padding(.horizontal, 32)
                            }
                        }
                        .foregroundColor(.primary)
                        Divider()
                    }
                }
            }
            .offset(x: 15)
        }
    }
}

struct RecentSearchesList_Previews: PreviewProvider {
    static var previews: some View {
        RecentSearchesList() { _ in }
    }
}
