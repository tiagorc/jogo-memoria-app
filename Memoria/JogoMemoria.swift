//
//  JogoMemoria.swift
//  Memoria
//
//  Created by Pedro Henrique on 08/03/21.
//

import Foundation

struct JogoMemoria<ConteudoCarta> where ConteudoCarta: Equatable { //Model
    var cartas: [Carta]
    
    private var indiceUnicaCartaViradaParaCima: Int?
    
    private var indiceCartaPreviamenteEscolhida: Int? {
        get {
            cartas.indices.filter { cartas[$0].estaViradaParaCima }.only
        }
        set {
            for index in cartas.indices {
                cartas[index].estaViradaParaCima = index == newValue
            }
        }
    }
    
    
    init(numeroParesCartas: Int, fabricaConteudoCartas: (Int) -> ConteudoCarta) {
        
        cartas = Array<Carta>()
        for indicePar in 0..<numeroParesCartas {
            let conteudo = fabricaConteudoCartas(indicePar)
            cartas.append(Carta(id: indicePar * 2, conteudo: conteudo))
            cartas.append(Carta(id: indicePar * 2 + 1, conteudo: conteudo))
        }
        cartas.shuffle()
    }
    
    mutating func escolher(carta: Carta) {
        print("Carta escolhida: \(carta)")
        
        if let indiceCartaEscolhida = cartas.firstIndex(matching: carta) {
            if let possivelCombinacao = indiceCartaPreviamenteEscolhida {
                if cartas[indiceCartaEscolhida].conteudo == cartas[possivelCombinacao].conteudo {
                    cartas[indiceCartaEscolhida].estaCombina = true
                    cartas[possivelCombinacao].estaCombina = true
                }
                cartas[indiceCartaEscolhida].estaViradaParaCima = true
            }else {
                indiceCartaPreviamenteEscolhida = indiceCartaEscolhida
            }
        }
        
    }
    
    
    struct Carta: Identifiable {
        var id: Int
        var estaViradaParaCima = false
        var estaCombina = false
        var conteudo: ConteudoCarta
        
    
    }
    
}
