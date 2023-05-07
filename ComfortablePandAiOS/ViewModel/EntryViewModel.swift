//
//  EntryViewModel.swift
//  ComfortablePandAiOS
//
//  Created by Kazuki Takeda on 2023/05/07.
//

import SwiftUI

class EntryViewModel: ObservableObject {
    @Published var entryModels: [EntryModel] = []
    
    init() {
        self.entryModels = DemoEntry.entries
    }
    
    var entries: [EntryModel] {
        entryModels
    }
}

