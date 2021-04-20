//
//  SegmojiClockWidget.swift
//  SegmojiClockWidget
//
//  Created on 12/12/20.
//  Copyright © 2020 Kevin Scardina. All rights reserved.
//

import WidgetKit
import SwiftUI
import Intents

struct Provider: IntentTimelineProvider {
    func placeholder(in context: Context) -> SimpleEntry {
        SimpleEntry(date: Date(), configuration: ConfigurationIntent())
    }

    func getSnapshot(for configuration: ConfigurationIntent,
					 in context: Context,
					 completion: @escaping (SimpleEntry) -> ()) {
        let entry = SimpleEntry(date: Date(), configuration: configuration)
        completion(entry)
    }

    func getTimeline(for configuration: ConfigurationIntent,
					 in context: Context,
					 completion: @escaping (Timeline<Entry>) -> ()) {
		var entries = [SimpleEntry]()
		let now = Date()
		for offset in 0...60*20 {
			let date = Calendar.current.date(byAdding: .second,
											 value: offset,
											 to: now)!
			entries.append(
				SimpleEntry(
					date: date,
					configuration: configuration
				)
			)
		}
		let timeline = Timeline(
			entries: entries,
			policy: .after(
				Date().addingTimeInterval(60*20)
			)
		)
        completion(timeline)
    }
}

struct SimpleEntry: TimelineEntry {
    let date: Date
    let configuration: ConfigurationIntent
}

struct SegmojiClockWidgetEntryView : View {
    var entry: Provider.Entry

    var body: some View {
		GeometryReader { geo in
			ZStack {
				Color.black
				Text(
					Emoji.random
				)
				.font(
					.system(
						size: CGFloat(
							Double.minimum(
								Double(geo.size.height),
								Double(geo.size.height)
							) / 2
						)
					)
				)
				VStack {
					let fontName = "Menlo"
					let fontSize: CGFloat = 26.0
					let opacity = 0.8
					HStack {
						let hour = Calendar.current.component(.hour,
															  from: entry.date)
						let minute = Calendar.current.component(.minute,
																from: entry.date)
						Spacer()
						Text(Emoji.from(hour / 10) + Emoji.from(hour % 10))
							.font(.custom(fontName, size: fontSize))
//							.opacity(opacity)
						Text(Emoji.colon)
							.font(.custom(fontName, size: 12.0))
							.foregroundColor(Color.white)
//							.opacity(opacity)
						Text(Emoji.from(minute / 10) + Emoji.from(minute % 10))
							.font(.custom(fontName, size: fontSize))
//							.opacity(opacity)
						Spacer()
					}
					.padding(.top, 8.0)
					Spacer()
					let seconds = Calendar.current.component(.second,
															 from: entry.date)
					Text(Emoji.from(seconds / 10) + Emoji.from(seconds % 10))
						.font(.custom(fontName, size: fontSize))
						.padding(.bottom, 8.0)
//						.opacity(opacity)
				}
			}
		}
	}
}

@main
struct SegmojiClockWidget: Widget {
    let kind: String = "SegmojiClockWidget"

    var body: some WidgetConfiguration {
        IntentConfiguration(kind: kind,
							intent: ConfigurationIntent.self,
							provider: Provider()) { entry in
            SegmojiClockWidgetEntryView(entry: entry)
        }
        .configurationDisplayName("Segmoji Clock Widget")
        .description("This is an example widget.")
    }
}

struct SegmojiClockWidget_Previews: PreviewProvider {
    static var previews: some View {
        SegmojiClockWidgetEntryView(
			entry: SimpleEntry(
				date: Date(),
				configuration: ConfigurationIntent()
			)
		)
		.previewContext(WidgetPreviewContext(family: .systemSmall))
    }
}
