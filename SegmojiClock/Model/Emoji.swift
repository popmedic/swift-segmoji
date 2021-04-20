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
	static let numbers = [
		"0️⃣", "1️⃣", "2️⃣", "3️⃣", "4️⃣", "5️⃣", "6️⃣", "7️⃣", "8️⃣", "9️⃣"
	]
	static let colon = ":"
	static let blank = ""
	static func from(_ int: Int) -> String {
		guard 0...9 ~= int else { return blank }
		return numbers[int]
	}
}
