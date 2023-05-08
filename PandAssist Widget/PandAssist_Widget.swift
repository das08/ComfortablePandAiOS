//
//  PandAssist_Widget.swift
//  PandAssist Widget
//
//  Created by Kazuki Takeda on 2023/05/06.
//

import WidgetKit
import SwiftUI

struct Provider: TimelineProvider {
    func placeholder(in context: Context) -> SimpleEntry {
        SimpleEntry(date: Date())
    }

    func getSnapshot(in context: Context, completion: @escaping (SimpleEntry) -> ()) {
        let entry = SimpleEntry(date: Date())
        completion(entry)
    }

    func getTimeline(in context: Context, completion: @escaping (Timeline<Entry>) -> ()) {
        var entries: [SimpleEntry] = []

        // Generate a timeline consisting of five entries an hour apart, starting from the current date.
        let currentDate = Date()
        for hourOffset in 0 ..< 5 {
            let entryDate = Calendar.current.date(byAdding: .hour, value: hourOffset, to: currentDate)!
            let entry = SimpleEntry(date: entryDate)
            entries.append(entry)
        }

        let timeline = Timeline(entries: entries, policy: .atEnd)
        completion(timeline)
    }
}

struct SimpleEntry: TimelineEntry {
    let date: Date
}

struct PandAssist_WidgetEntryView : View {
    let entry: Provider.Entry
    
    @ViewBuilder
    var body: some View {
        WidgetView()
    }
}

struct PandAssist_Widget: Widget {
    let kind: String = "PandAssist_Widget"

    var body: some WidgetConfiguration {
        StaticConfiguration(
            kind: kind,
            provider: Provider()
        ) {entry in
            PandAssist_WidgetEntryView(entry: entry)
                .background(miniPandAColor().background)
        }
        .supportedFamilies([.systemLarge])
        .configurationDisplayName("miniPandA")
        .description("取得した課題一覧をウィジェットで簡単に確認できます")
    }
}

struct PandAssist_Widget_Previews: PreviewProvider {
    static var previews: some View {
        PandAssist_WidgetEntryView(entry: SimpleEntry(date: Date()))
            .background(miniPandAColor().background)
            .previewContext(WidgetPreviewContext(family: .systemLarge))
    }
}
