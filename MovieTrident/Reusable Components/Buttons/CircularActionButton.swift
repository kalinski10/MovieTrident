//
//  CircularActionButton.swift
//  MovieTrident
//
//  Created by kalin's personal on 12/12/2021.
//

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
                .foregroundColor(isPrimary ? .white : Brand.Colour.primary)
                .background(
                    Circle()
                        .foregroundColor(isPrimary ? Brand.Colour.primary : .white)
                )
        }
    }
}


struct CircularActionButton_Previews: PreviewProvider {
    static var previews: some View {
        CircularActionButton(imageName: "slider.horizontal.3", isPrimary: true) { }
    }
}
