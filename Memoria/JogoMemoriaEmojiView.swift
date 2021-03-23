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
                CardView(carta: carta)
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
    
    @State
    private var tempoRestanteBonus: Double = 0
    
    private func comecarAnimacaoCronometro() {
        tempoRestanteBonus = carta.bonusRestante
        withAnimation(.linear(duration: carta.tempoBonusRestante)) {
            tempoRestanteBonus = 0
        }
    }
    
    var body: some View {
        GeometryReader { geometry in
            if carta.estaViradaParaCima || !carta.estaCombinada {
                ZStack {
                    Group {
                        if carta.estaConsumindoTempoBonus {
                            Cronometro(anguloInicial: Angle.degrees(0-90),
                                       anguloFinal: Angle.degrees(-tempoRestanteBonus * 360 - 90),
                                       sentidoHorario: true)
                            .onAppear {
                                comecarAnimacaoCronometro()
                            }
                        }else {
                            Cronometro(anguloInicial: Angle.degrees(0-90),
                                       anguloFinal: Angle.degrees(-carta.bonusRestante * 360 - 90),
                                       sentidoHorario: true)
                        }
                    }
                    .opacity(0.5)
                    .padding(4)
                    
                    Text(carta.conteudo)
                        .font(Font.system(size: tamanhoFonte(para: geometry.size)))
                }
                .fazerCarta(viradaParaCima: carta.estaViradaParaCima)
                .transition(.scale)
            }
        }
    }
    
    
    // MARK: - Constantes e Funções de Desenho
    
    private func tamanhoFonte(para tamanho: CGSize) -> CGFloat {
        return min(tamanho.width, tamanho.height) * 0.7
    }
}























struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        JogoMemoriaEmojiView(viewModel: JogoMemoriaEmoji())
    }
}
