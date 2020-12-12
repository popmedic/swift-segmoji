//
//  SegmojiClock
//
//  Created on 12/12/20.
//  Copyright © 2020 Kevin Scardina. All rights reserved.
//

import Foundation


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
