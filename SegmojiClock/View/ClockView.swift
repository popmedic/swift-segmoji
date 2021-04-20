//
//  SegmojiClock
//
//  Created on 12/12/20.
//  Copyright © 2020 Kevin Scardina. All rights reserved.
//

import SwiftUI

public struct ClockView: View {
    @ObservedObject var clock = Clock()
    
    private let fontName: String
    private let fontSize: CGFloat
    private let showSeconds: Bool
    
    public init(fontName: String = "Menlo",
				fontSize: CGFloat = 10.0,
				showSeconds: Bool = true) {
        self.fontName = fontName
        self.fontSize = fontSize
        self.showSeconds = showSeconds
    }
    public var body: some View {
        HStack {
			Text(clock.time.0.display)
				.font(.custom(fontName, size: fontSize))
			Text(clock.time.1.display)
				.font(.custom(fontName, size: fontSize))
			Text(SevenSegment.colon.display)
				.font(.custom(fontName, size: fontSize))
			Text(clock.time.2.display)
				.font(.custom(fontName, size: fontSize))
			Text(clock.time.3.display)
				.font(.custom(fontName, size: fontSize))
			if showSeconds {
				Text(SevenSegment.colon.display)
				.font(.custom(fontName, size: fontSize))
				Text(clock.time.4.display)
					.font(.custom(fontName, size: fontSize))
				Text(clock.time.5.display)
					.font(.custom(fontName, size: fontSize))
			}
        }
    }
}
