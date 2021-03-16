//
//  JogoMemoriaEmojiView.swift
//  Memoria
//
//  Created by Pedro Henrique on 08/03/21.
//

import SwiftUI

struct JogoMemoriaEmojiView: View { // View
    
    @ObservedObject
    var viewModel: JogoMemoriaEmoji
    
    var body: some View {
        VStack {
            Grid(viewModel.cartas) { carta in
                CardView(carta: carta, numeroPares: viewModel.numeroPares)
                    .onTapGesture {
                        withAnimation(.linear) {
                            viewModel.escolher(carta: carta)
                        }
                    }
                    .padding(4)
            }
            
            Button("Novo Jogo") {
                withAnimation(.easeInOut) {
                    viewModel.novoJogo()
                }
            }
        }
        
        .padding()
        .foregroundColor(Color.purple)
    }
    
}


struct CardView: View {
    var carta: JogoMemoria<String>.Carta
    var numeroPares: Int
    
    private var fonteConteudo: Font {
        if numeroPares == 5 {
            return Font.caption
        }
        return Font.headline
    }
    
    var body: some View {
        ZStack{
            RoundedRectangle(cornerRadius: 12)
                .stroke(lineWidth: 4)
            Text(carta.conteudo)
                .font(fonteConteudo)
            
            if !carta.estaViradaParaCima {
                RoundedRectangle(cornerRadius: 12)
            }
        }
        .rotation3DEffect(Angle.degrees(carta.estaViradaParaCima ? 0 : 180), axis: (0, 1, 0))
    }
}























struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        JogoMemoriaEmojiView(viewModel: JogoMemoriaEmoji())
    }
}
