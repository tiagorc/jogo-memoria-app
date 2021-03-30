//
//  MemoriaApp.swift
//  Memoria
//
//  Created by Pedro Henrique on 08/03/21.
//

import SwiftUI

/*
 Exercício 2
 
 Exercício pra hoje, valendo nota:

 1. Refatorar a CardModifier para extrair funções responsáveis pela frente e pelo verso da carta. Usar o @ViewBuilder;

 2. Criar temas para o nosso jogo da Memória:

     - Cores
     - Emojis diferentes

 Pelo menos 3 temas.
 
 
 */

@main
struct MemoriaApp: App {
    
    
    
    var body: some Scene {
        WindowGroup {
            TemaView()
            
        }
    }
}
