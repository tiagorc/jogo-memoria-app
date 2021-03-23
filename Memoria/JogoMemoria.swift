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
                    cartas[indiceCartaEscolhida].estaCombinada = true
                    cartas[possivelCombinacao].estaCombinada = true
                }
                cartas[indiceCartaEscolhida].estaViradaParaCima = true
            }else {
                indiceCartaPreviamenteEscolhida = indiceCartaEscolhida
            }
        }
        
    }
    
    
    struct Carta: Identifiable {
        var id: Int
        var estaViradaParaCima = false {
            didSet {
                if estaViradaParaCima {
                    comecarUsarTempoBonus()
                }else {
                    pararUsarTempoBonus()
                }
            }
        }
        var estaCombinada = false {
            didSet {
                pararUsarTempoBonus()
            }
        }
        var conteudo: ConteudoCarta
        
        var tempoBonus: TimeInterval = 6
        
        var ultimaVezVirouParaCima: Date?
        var ultimoTempoQueFicouViradaParaCima: TimeInterval = 0
        
        private var tempoViradaParaCima: TimeInterval {
            if let ulimaVirada = self.ultimaVezVirouParaCima {
                return ultimoTempoQueFicouViradaParaCima + Date().timeIntervalSince(ulimaVirada)
            }else {
                return ultimoTempoQueFicouViradaParaCima
            }
        }
        
        var bonusRestante: Double {
            (tempoBonus > 0 && tempoBonusRestante > 0) ? tempoBonusRestante / tempoBonus : 0
        }
        
        var tempoBonusRestante: TimeInterval {
            max(0, tempoBonus - tempoViradaParaCima)
        }
        
        var estaConsumindoTempoBonus: Bool {
            estaViradaParaCima && !estaCombinada && tempoBonusRestante > 0
        }
        
        private mutating func comecarUsarTempoBonus() {
            if estaConsumindoTempoBonus, ultimaVezVirouParaCima == nil {
                ultimaVezVirouParaCima = Date()
            }
         }
        
        private mutating func pararUsarTempoBonus() {
            ultimoTempoQueFicouViradaParaCima = tempoViradaParaCima
            ultimaVezVirouParaCima = nil
        }
    
    }
    
}
