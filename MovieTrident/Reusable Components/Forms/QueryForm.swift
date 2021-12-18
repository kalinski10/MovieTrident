//
//  QueryForm.swift
//  MovieTrident
//
//  Created by Kalin Balabanov on 15/12/2021.
//

import SwiftUI

struct QueryForm: View {
    
    @ObservedObject var vm: EntryVieModel
    
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
            
        }
        .frame(height: 160)
    }
}

struct QueryForm_Previews: PreviewProvider {
    static var previews: some View {
        QueryForm(vm: EntryVieModel())
    }
}
