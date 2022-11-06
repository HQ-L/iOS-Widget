//
//  DataShow.swift
//  DataShow
//
//  Created by hq on 2022/11/6.
//

import WidgetKit
import SwiftUI

struct Provider: TimelineProvider {
    func placeholder(in context: Context) -> SimpleEntry {
        SimpleEntry(date: Date(), text: "rip")
    }

    func getSnapshot(in context: Context, completion: @escaping (SimpleEntry) -> ()) {
        let entry = SimpleEntry(date: Date(), text: "rip")
        completion(entry)
    }

    func getTimeline(in context: Context, completion: @escaping (Timeline<Entry>) -> ()) {

        let userDefaults = UserDefaults(suiteName: "group.learn.lihuiqi")
        let textShow = userDefaults?.value(forKey: "text") as? String ?? "rip"
        var entries: [SimpleEntry] = []

        // Generate a timeline consisting of five entries an hour apart, starting from the current date.
        let currentDate = Date()
        for hourOffset in 0 ..< 5 {
            let entryDate = Calendar.current.date(byAdding: .hour, value: hourOffset, to: currentDate)!
            let entry = SimpleEntry(date: entryDate, text: textShow)
            entries.append(entry)
        }

        let timeline = Timeline(entries: entries, policy: .atEnd)
        completion(timeline)
    }
}

struct SimpleEntry: TimelineEntry {
    let date: Date
    let text: String
}

struct DataShowEntryView : View {
    var entry: Provider.Entry

    var body: some View {
        ZStack(alignment: .topTrailing) {
            Image("\(entry.text)")
                .resizable()
                .scaledToFit()
            Text("我是佩奇加的水印")
                .foregroundColor(.gray)
                .padding(.horizontal)
                .font(.footnote)
        }
    }
}

@main
struct DataShow: Widget {
    let kind: String = "DataShow"

    var body: some WidgetConfiguration {
        StaticConfiguration(kind: kind, provider: Provider()) { entry in
            DataShowEntryView(entry: entry)
        }
        .configurationDisplayName("My Widget")
        .description("This is an example widget.")
    }
}

struct DataShow_Previews: PreviewProvider {
    static var previews: some View {
        DataShowEntryView(entry: SimpleEntry(date: Date(), text: "rip"))
            .previewContext(WidgetPreviewContext(family: .systemSmall))
    }
}
