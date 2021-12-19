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
        
        TextField("Enter a keyword here", text: $searchInput)
            .padding()
            .frame(height: 50)
            .background(Color(.systemGray6))
            .clipShape(Capsule())
            .focused($isFocused)
            .onSubmit(action)
            .onTapGesture {
                isFocused = true
            }
        
    }
}

struct MTTextfield_Previews: PreviewProvider {
    static var previews: some View {
        MTTextfield(searchInput: .constant(""), isFocused: .init()) { }
    }
}
