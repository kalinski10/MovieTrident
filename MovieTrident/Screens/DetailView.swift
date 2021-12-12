//
//  DetailView.swift
//  MovieTrident
//
//  Created by kalin's personal on 10/12/2021.
//

import SwiftUI

struct DetailView: View {
    
    @Binding var isShowing: Bool
    @State private var showHint: Bool = false
    
    var body: some View {
        ZStack(alignment: .top) {
            
            Image("ThorPoster")
                .resizable()
                .frame(maxHeight: .infinity)
                .frame(maxWidth: .infinity)
                .scaledToFill()
                .ignoresSafeArea()
            
            VStack {
                
                HStack {
                    CircularActionButton(imageName: "chevron.left", isPrimary: false, action: hideView)
                    Spacer()
                    CircularActionButton(imageName: "bookmark", isPrimary: false) { }
                }
                
                Spacer()

                VStack(alignment: .leading) {
                    
                    Text("Thor Ragnarok - 2017")
                        .font(.title)
                        .bold()
                    
                    Text("Action, Adventure, Comedy")

                    Divider()

                    HStack {
                        Label("7.9", systemImage: "star")
                            .overlay(
                                Text("imbd rating")
                                    .padding(4)
                                    .foregroundColor(.white)
                                    .background(.gray)
                                    .offset(x: 30, y: 25)
                                    .opacity(showHint ? 1 : 0)
                            )
                            .onTapGesture {
                                withAnimation {
                                    showHint.toggle()
                                }
                            }
                        
                        Spacer()
                        
                        Label("Taika Waititi", systemImage: "video")
                        
                        Spacer()
                        
                        Label("130", systemImage: "timer")
                    }
                    
                    Text("Imprisoned on the planet Sakaar, Thor must race against time to return to Asgard and stop Ragnarök, the destruction of his world, at the hands of the powerful and ruthless villain Hela.")
                        .multilineTextAlignment(.leading)
                        .padding(.top)

                }
                .padding()
                .foregroundColor(.white)
                .background(.ultraThinMaterial)
                .clipShape(RoundedRectangle(cornerRadius: 24))
            }
            .frame(width: UIScreen.main.bounds.width*0.9)
            .padding(32)
        }
    }
}

private extension DetailView {
    func hideView() {
        withAnimation {
            isShowing = false
        }
    }
}

struct DetailView_Previews: PreviewProvider {
    static var previews: some View {
        DetailView(isShowing: .constant(true))
    }
}
