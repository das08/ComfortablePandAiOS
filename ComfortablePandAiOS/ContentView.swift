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
    @ObservedResults(CourseInfo.self,configuration: RealmManager().configuration) var courses
    @ObservedResults(EntryModel.self,configuration: RealmManager().configuration) var entries
    @ObservedResults(UserInfoModel.self,configuration: RealmManager().configuration) var stats
    
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
              realm.add(UserInfoModel())
            }
        }
        SakaiAPI.shared.ensureUserIsLoggedIn { result in
            switch result {
            case .success(let courses):
                print("success, courses: \(courses)")
                async {
                    do {
                        let assignments = try await SakaiAPI.shared.fetchAssignment2(course: courses[1])
                        print(assignments)
                    } catch {
                        print("Failed to fetch assignments: \(error)")
                    }
                }
            case .failure(let error):
                print("error: \(error)")
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
