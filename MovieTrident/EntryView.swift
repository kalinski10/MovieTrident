//
//  ContentView.swift
//  MovieTrident
//
//  Created by kalin's personal on 09/12/2021.
//

import SwiftUI

struct EntryView: View {
    
    @State private var text: String = ""
    @State private var isShowingDetailView: Bool = false
    
    let placeHolderText: String = "search"
    let primaryColour = CGColor(red: 0, green: 0.388, blue: 0.239, alpha: 1)
    
    var body: some View {
        ZStack {
            // empty state
            VStack {
                Spacer()
                Image(systemName: "list.and.film")
                    .resizable()
                    .scaledToFit()
                    .frame(width: 200, height: 200)
                
                Text("You haven't searched for any movies just yet")
                    .bold()
                    .font(.largeTitle)
            }
            .foregroundColor(Color(primaryColour))
            
            
            VStack {
                HStack {
                    Text("Search for \nany movies here")
                        .font(.largeTitle)
                        .bold()
                        .multilineTextAlignment(.leading)
                    Spacer()
                }

                
                HStack(spacing: 16) {
                    TextField("Enter a keyword here ", text: $text)
                        .padding()
                        .frame(height: 50)
                        .background(Color(.systemGray6))
                        .clipShape(Capsule())
                    
                    Button {
                        isShowingDetailView = true
                    } label: {
                        Image(systemName: "slider.horizontal.3")
                            .resizable()
                            .scaledToFit()
                            .padding()
                            .frame(height: 50)
                            .background(Color(primaryColour))
                            .clipShape(Circle())
                            .foregroundColor(.white)
                    }
                }
                
                Spacer()
            }
        }
        .padding(32)
        .sheet(isPresented: $isShowingDetailView) {
            DetailView()
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        EntryView()
            .preferredColorScheme(.light)
    }
}
