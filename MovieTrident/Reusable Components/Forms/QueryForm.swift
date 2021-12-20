import SwiftUI

struct QueryForm: View {
    
    @ObservedObject var vm: EntryViewModelImpl
    
    var body: some View {
        VStack(alignment: .leading, spacing: 8) {
            LazyHStack {
                ForEach(vm.movieTypes, id: \.self) { type in
                    Button(type) {
                        vm.type = type
                    }
                    .buttonStyle(.bordered)
                    .tint(vm.type == type ? Brand.Colour.primary : .white)
                }
            }
            .frame(maxHeight: .infinity)
            
            ScrollView(.horizontal, showsIndicators: false) {
                LazyHStack {
                    ForEach(vm.years.reversed(), id: \.self) { year in
                        Button(year) {
                            vm.year = year
                        }
                        .buttonStyle(.bordered)
                        .tint(vm.year == year ? Brand.Colour.primary : .white)
                    }
                }
            }
            
            HStack {
                Spacer()
                Button("Reset Filters") {
                    vm.year.removeAll()
                    vm.type.removeAll()
                }
                .buttonStyle(.bordered)
                .tint(Color(.systemRed))
            }
            
        }
        .padding()
        .background(Color(.systemGray3))
        .cornerRadius(16)
        .frame(maxHeight: 150)
        .padding(.horizontal, 32)
    }
}

struct QueryForm_Previews: PreviewProvider {
    static var previews: some View {
        QueryForm(vm: EntryViewModelImpl())
    }
}
