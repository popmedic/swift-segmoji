//
//  SegmojiClock
//
//  Created on 12/11/20.
//  Copyright © 2020 Kevin Scardina. All rights reserved.
//

import SwiftUI

struct RootView: View {
    var body: some View {
        ClockView()
    }
}

struct ClockView: View {
    @ObservedObject var clock = Clock()
    
    var body: some View {
        HStack {
            Text(clock.time.0.display).font(.custom("Menlo", size: 10))
            Text(clock.time.1.display).font(.custom("Menlo", size: 10))
            Text(SevenSegment.colon.display).font(.custom("Menlo", size: 10))
            Text(clock.time.2.display).font(.custom("Menlo", size: 10))
            Text(clock.time.3.display).font(.custom("Menlo", size: 10))
            Text(SevenSegment.colon.display).font(.custom("Menlo", size: 10))
            Text(clock.time.4.display).font(.custom("Menlo", size: 10))
            Text(clock.time.5.display).font(.custom("Menlo", size: 10))
        }
    }
}

struct RootView_Previews: PreviewProvider {
    static var previews: some View {
        RootView()
    }
}
