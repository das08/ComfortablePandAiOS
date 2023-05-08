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
    let manager = RealmManager()
    @ObservedResults(EntryModel.self,configuration: Realm.Configuration(fileURL:RealmManager().fileUrl)) var entries
    
    init() {
        let demoEntries = DemoEntry.entries
        if entries.isEmpty {
            print("creating new entries")
            try? realm.write {
              realm.add(demoEntries)
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
