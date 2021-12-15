//
//  MTTextfield.swift
//  MovieTrident
//
//  Created by Kalin Balabanov on 13/12/2021.
//

import SwiftUI

struct MTTextfield: View {
    
    @Binding var searchInput: String
    @FocusState private var isFocused: Bool
    let action: () -> Void
    
    init(
        searchInput: Binding<String>,
        isFocused: FocusState<Bool>,
        action: @escaping () -> Void
    ) {
        self._searchInput = searchInput
        self._isFocused = isFocused
        self.action = action
    }
    
    var body: some View {
        TextField("Enter a keyword here", text: $searchInput) { isEditing in
            handleTextfieldInput(with: isEditing)
        }
        .padding()
        .frame(height: 50)
        .background(Color(.systemGray6))
        .clipShape(Capsule())
        .focused($isFocused)
        .onSubmit(action)
        
    }
}

private extension MTTextfield {
    func handleTextfieldInput(with isEditing: Bool) {
        if isEditing {
            withAnimation {
                isFocused = true
            }
            
        } else {
            withAnimation {
                isFocused = false
            }
        }
    }
}

//struct MTTextfield_Previews: PreviewProvider {
//    static var previews: some View {
//        MTTextfield()
//    }
//}
