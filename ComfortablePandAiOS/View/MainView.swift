//
//  MainView.swift
//  ComfortablePandAiOS
//
//  Created by Kazuki Takeda on 2023/05/06.
//

import SwiftUI

struct MainView: View {
    @State var entries: [EntryModel]
    init(entries: [EntryModel]) {
        UINavigationBar.appearance().titleTextAttributes = [.font: UIFont.systemFont(ofSize: 26)]
        UINavigationBar.appearance().barTintColor = UIColor.white
        UINavigationBar.appearance().backgroundColor = UIColor.white
        UITabBar.appearance().barTintColor = UIColor.white
        UITabBar.appearance().backgroundColor = UIColor.white
        
        self.entries = entries
    }
    var body: some View {
        TabView {
            NavigationView {
                ScrollView (.vertical, showsIndicators: false) {
                    VStack {
                        ForEach(entries) { entry in
                            EntryView(entry: entry)
                            Divider()
                        }
                    }
                }
                    // タイトルと左右のアイコンを指定
                    .navigationBarTitle(Text("🐼"), displayMode: .inline)
                    .navigationBarItems(
                        trailing: VStack{
                            Text("取得: 23分前")
                        }
                        .padding(.bottom, 10)
                    )
                }
                .tabItem {
                    IconView(systemName: "house")
                }
            IconView(systemName: "bell")
                .tabItem {
                    IconView(systemName: "bell")
                }
            IconView(systemName: "gear")
                .tabItem {
                    IconView(systemName: "gear")
                }
        }
        // 選択されているアイコンの色を青に変更
        .accentColor(.blue)
    }
}

struct IconView: View {
    var systemName: String

    var body: some View {
        Image(systemName: systemName)
            .font(.title)
    }
}

struct MainView_Previews: PreviewProvider {
    static var previews: some View {
        MainView(entries: MainView.demoEntries)
    }
}

extension MainView {
    static var demoEntries = [
        EntryModel(entryType: .Assignment, courseInfo: CourseInfo(id: "abc123", courseName: "電気電子工学"), title: "課題1", description: "課題1の詳細", dueDate: Date(), hasFinished: false, isNew: true),
        EntryModel(entryType: .Assignment, courseInfo: CourseInfo(id: "abc123", courseName: "電気電子工学"), title: "課題1", description: "課題1の詳細", dueDate: Date(), hasFinished: false, isNew: true),
        EntryModel(entryType: .Assignment, courseInfo: CourseInfo(id: "abc123", courseName: "電気電子工学"), title: "課題1", description: "課題1の詳細", dueDate: Date(), hasFinished: false, isNew: true),
        EntryModel(entryType: .Assignment, courseInfo: CourseInfo(id: "abc123", courseName: "電気電子工学"), title: "課題1", description: "課題1の詳細", dueDate: Date(), hasFinished: false, isNew: true)
    ]
}
