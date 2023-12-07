//
//  ContentView.swift
//  RickAndMorty
//
//  Created by Atharian Rahmadani on 06/12/23.
//

import SwiftUI

struct ContentView: View {
    
    @StateObject private var vm = CharacterViewModel(service: CharacterService())
    
    var body: some View {
        NavigationView {
            switch vm.state {
            case .success(let data):
                List {
                    ForEach(data, id: \.id) { datum in
                        /*@START_MENU_TOKEN@*/Text(datum.name)/*@END_MENU_TOKEN@*/
                    }
                }
                .navigationBarTitle("Characters")
                .navigationBarHidden(false)
            case .loading:
                ProgressView()
            default:
                EmptyView()
            }
        }
        .task {
            await vm.getCharacters()
        }
        .alert("Error", isPresented: $vm.hasError, presenting: vm.state) { detail in
            Button("Retry") {
                Task {
                    await vm.getCharacters()
                }
            }
        } message: { detail in
            if case let .failed(error) = detail {
                Text(error.localizedDescription)
            }
        }
    }
}

#Preview {
    ContentView()
}
