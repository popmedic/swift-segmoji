//
//  SegmojiClock
//
//  Created on 12/11/20.
//  Copyright © 2020 Kevin Scardina. All rights reserved.
//

import Foundation
import Combine

final class Clock: ObservableObject {
    typealias TimeSegmented = (
        SevenSegment,
        SevenSegment,
        SevenSegment,
        SevenSegment,
        SevenSegment,
        SevenSegment
    )
    @Published
    var time: TimeSegmented = (SevenSegment.blank,
                               SevenSegment.blank,
                               SevenSegment.blank,
                               SevenSegment.blank,
                               SevenSegment.blank,
                               SevenSegment.blank)
	
	static func getTime(from date: Date) -> TimeSegmented {
		let calendar = Calendar.current
		let hours = calendar.component(.hour, from: date)
		let minutes = calendar.component(.minute, from: date)
		let seconds = calendar.component(.second, from: date)
		let segmented = { (_ int: Int) -> (SevenSegment, SevenSegment) in
			(
				SevenSegment.from(int / 10),
				SevenSegment.from(int % 10)
			)
		}
		let segmentedHours = segmented(hours)
		let segmentedMinutes = segmented(minutes)
		let segmentedSeconds = segmented(seconds)
		return (
			segmentedHours.0, segmentedHours.1,
			segmentedMinutes.0, segmentedMinutes.1,
			segmentedSeconds.0, segmentedSeconds.1
		)
	}
    
    private let runQueue: DispatchQueue?
	
    init() {
        runQueue = DispatchQueue(label: "\(Self.self).runQueue")
        fire()
    }
	
    private func fire() {
		let time = Self.getTime(from: Date())
        DispatchQueue.main.async { [weak self] in self?.time = time }
        runQueue?.asyncAfter(deadline: .now() + 1.0) { [weak self] in
            self?.fire()
        }
    }
}
