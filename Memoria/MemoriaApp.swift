//
//  MemoriaApp.swift
//  Memoria
//
//  Created by Pedro Henrique on 08/03/21.
//

import SwiftUI

@main
struct MemoriaApp: App {
    
    let viewModel = JogoMemoriaEmoji()
    
    var body: some Scene {
        WindowGroup {
            JogoMemoriaEmojiView(viewModel: viewModel)
        }
    }
}
