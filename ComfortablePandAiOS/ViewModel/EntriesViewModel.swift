//
//  EntryViewModel.swift
//  ComfortablePandAiOS
//
//  Created by Kazuki Takeda on 2023/05/07.
//

import SwiftUI

class EntriesViewModel: ObservableObject {
    @Published var entryModels: [EntryModel] = []
    
    init() {
        self.entryModels = DemoEntry.entries
    }
    
    var entries: [EntryModel] {
        entryModels
    }
}

//class EntryViewModel: ObservableObject {
//    @Published var entry: EntryModel
//
//    init(entry: EntryModel) {
//        self.entry = entry
//    }
//
//    func toggleHasFinished() {
//        self.entry.hasFinished.toggle()
//    }
//}

