//
//  SegmojiClock
//
//  Created on 12/12/20.
//  Copyright © 2020 Kevin Scardina. All rights reserved.
//

import Foundation

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
