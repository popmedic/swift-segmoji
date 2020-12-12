//
//  SegmojiClock
//
//  Created on 12/11/20.
//  Copyright © 2020 Kevin Scardina. All rights reserved.
//

import Foundation
import Combine

class Clock: ObservableObject {
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
    
    private let runQueue: DispatchQueue
    private func getTime() -> TimeSegmented {
        let hours = Calendar.current.component(.hour, from: Date())
        let minutes = Calendar.current.component(.minute, from: Date())
        let seconds = Calendar.current.component(.second, from: Date())
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
    init() {
        runQueue = DispatchQueue(label: "\(Self.self).runQueue")
        fire()
    }
    private func fire() {
        let time = getTime()
        DispatchQueue.main.async { [weak self] in self?.time = time }
        runQueue.asyncAfter(deadline: .now() + 1.0) { [weak self] in
            self?.fire()
        }
    }
}

enum SevenSegment: String {
    case
    zero = """
    😁😁😁
    😁  😁
    😁  😁
    😁  😁
    😁  😁
    😁  😁
    😁😁😁
    """,
    one = """
        😁
        😁
        😁
        😁
        😁
        😁
        😁
    """,
    two = """
    😁😁😁
        😁
        😁
    😁😁😁
    😁
    😁
    😁😁😁
    """,
    three = """
    😁😁😁
        😁
        😁
    😁😁😁
        😁
        😁
    😁😁😁
    """,
    four = """
    😁  😁
    😁  😁
    😁  😁
    😁😁😁
        😁
        😁
        😁
    """,
    five = """
    😁😁😁
    😁
    😁
    😁😁😁
        😁
        😁
    😁😁😁
    """,
    six = """
    😁😁😁
    😁
    😁
    😁😁😁
    😁  😁
    😁  😁
    😁😁😁
    """,
    seven = """
    😁😁😁
        😁
        😁
        😁
        😁
        😁
        😁
    """,
    eight = """
    😁😁😁
    😁  😁
    😁  😁
    😁😁😁
    😁  😁
    😁  😁
    😁😁😁
    """,
    nine = """
    😁😁😁
    😁  😁
    😁  😁
    😁😁😁
        😁
        😁
    😁😁😁
    """,
    colon = """
    
    
     😁
    
     😁
    
    
    """,
    blank = ""
    
    var display: String {
        return self
            .rawValue
            .map { (c: Character) -> String in
                switch "\(c)" {
                case "😁": return Emoji.random
                default: return "\(c)"
                }
        }.joined()
    }
    static func from(_ int: Int) -> SevenSegment {
        switch int {
        case 0: return .zero
        case 1: return .one
        case 2: return .two
        case 3: return .three
        case 4: return .four
        case 5: return .five
        case 6: return .six
        case 7: return .seven
        case 8: return .eight
        case 9: return .nine
        default: return .blank
        }
    }
}

struct Emoji {
    private static let ranges = [
        0x1F600...0x1F636,
        0x1F645...0x1F64F,
        0x1F910...0x1F91E
    ]
    private static var randomRange: ClosedRange<Int> {
        ranges[Int.random(in: 0..<ranges.count)]
    }
    static var random: String {
        String(UnicodeScalar(Int.random(in: randomRange))!)
    }
}
