import SwiftUI

struct QueryForm: View {
    
    @ObservedObject var vm: EntryViewModelImpl
    
    var body: some View {
        List {
            
            Picker("Type", selection: $vm.type) {
                ForEach(vm.movieTypes, id: \.self) {
                    Text($0)
                }
            }
            
            Picker("Year", selection: $vm.year) {
                ForEach(vm.years.reversed(), id: \.self) {
                    Text($0)
                }
            }
            Button("Reset Filters") {
                vm.year.removeAll()
                vm.type.removeAll()
            }
            .foregroundColor(Color(.systemRed))
        }
        .frame(height: 200)
    }
}

struct QueryForm_Previews: PreviewProvider {
    static var previews: some View {
        QueryForm(vm: EntryViewModelImpl())
    }
}
