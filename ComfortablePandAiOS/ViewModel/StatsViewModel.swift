//
//  StatsViewModel.swift
//  ComfortablePandAiOS
//
//  Created by Kazuki Takeda on 2023/05/07.
//

import SwiftUI

class StatsViewModel: ObservableObject {
    @Published var statsModel: StatsModel
    
    init() {
        self.statsModel = StatsModel(userName: "dummy", lastAccessedTime: Date())
    }
    
    func getAccessedTime() -> String {
        return self.statsModel.formatLastAccessed()
    }
}
