//
//  MainView.swift
//  ComfortablePandAiOS
//
//  Created by Kazuki Takeda on 2023/05/06.
//

import SwiftUI

struct MainView: View {
    @StateObject var viewModel = EntryViewModel()
    @ObservedObject var statsViewModel = StatsViewModel()
    
    init() {
        UINavigationBar.appearance().titleTextAttributes = [.font: UIFont.systemFont(ofSize: 26)]
        UINavigationBar.appearance().barTintColor = UIColor.white
        UINavigationBar.appearance().backgroundColor = UIColor.white
        UITabBar.appearance().barTintColor = UIColor.white
        UITabBar.appearance().backgroundColor = UIColor.white
    }
    var body: some View {
        TabView {
            NavigationView {
                ScrollView (.vertical, showsIndicators: false) {
                    VStack {
                        ForEach(viewModel.entries) { entry in
                            EntryView(entry: entry)
                            Divider()
                        }
                    }
                }
                    // タイトルと左右のアイコンを指定
                    .navigationBarTitle(Text("🐼"), displayMode: .inline)
                    .navigationBarItems(
                        trailing: VStack{
                            Text(statsViewModel.getAccessedTime())
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
        MainView()
    }
}
