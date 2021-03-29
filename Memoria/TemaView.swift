//
//  TemaView.swift
//  Memoria
//
//  Created by Pedro Henrique on 29/03/21.
//

import SwiftUI

struct TemaView: View {
    
    private let viewModel = JogoMemoriaEmoji()
    
    var body: some View {
        NavigationView {
            NavigationLink(destination: JogoMemoriaEmojiView(viewModel: viewModel)) {
                Text("Ir pro jogo")
            }
            .navigationTitle("Jogo da Memória")
        }
    }
}

struct TemaView_Previews: PreviewProvider {
    static var previews: some View {
        TemaView()
    }
}
