//
//  ContentView.swift
//  ComfortablePandAiOS
//
//  Created by Kazuki Takeda on 2023/04/26.
//

import SwiftUI
import RealmSwift
import WidgetKit

struct ContentView: View {
    let realm = RealmManager().realm
    @ObservedResults(EntryModel.self,configuration: Realm.Configuration(fileURL:RealmManager().fileUrl)) var entries
    @ObservedResults(StatsModel.self,configuration: Realm.Configuration(fileURL:RealmManager().fileUrl)) var stats
    
    init() {
        let demoEntries = DemoEntry.entries
        if entries.isEmpty {
            print("creating new entries")
            try? realm.write {
              realm.add(demoEntries)
            }
        }
        if stats.isEmpty {
            print("creating new entries")
            try? realm.write {
              realm.add(StatsModel())
            }
        }
        SakaiAPI.shared.getLoginToken { result in
            switch result {
            case .success(let tokens):
                print("Login Token: \(tokens.LT ?? "nil")")
                print("Execution: \(tokens.EXE ?? "nil")")
            case .failure(let error):
                print("Error: \(error.localizedDescription)")
            }
        }
        WidgetCenter.shared.reloadAllTimelines()
    }
    var body: some View {
        MainView()
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
