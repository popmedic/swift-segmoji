//
//  SegmojiClock
//
//  Created on 12/11/20.
//  Copyright © 2020 Kevin Scardina. All rights reserved.
//

import SwiftUI

struct RootView: View {
    var body: some View {
        VStack {
            Text("Segmoji Clock")
                .foregroundColor(Color.white)
                .padding(.top)
                .font(Font.system(size: 24))
            ClockView(backgroundColor: Color.black,
                      fontName: "Menlo",
                      fontSize: 10.0,
                      showSeconds: false)
        }
        .background(Color.black)
    }
}

struct RootView_Previews: PreviewProvider {
    static var previews: some View {
        RootView()
    }
}
