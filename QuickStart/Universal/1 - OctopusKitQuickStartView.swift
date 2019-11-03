//
//  OctopusKitQuickStartView.swift
//  OctopusKitQuickStart
//
//  Created by ShinryakuTako@invadingoctopus.io on 2019/10/16.
//  Copyright © 2019 Invading Octopus. Licensed under Apache License v2.0 (see LICENSE.txt)
//

//  🔶 STEP 1: A SwiftUI view which displays the OctopusKit QuickStart "game".
//
//  Add this view in the `body` property of your SwiftUI project's `ContentView.swift` file.

import SwiftUI
import OctopusKit
import Combine

struct OctopusKitQuickStartView: View {
    
    var body: some View {
        
        #if os(iOS)

        return OctopusKitContainerView<MyGameCoordinator, MyGameViewController>()
            .environmentObject(MyGameCoordinator())
            .edgesIgnoringSafeArea(.all)
            .statusBar(hidden: true)

        #elseif os(macOS)

        return OctopusKitContainerView<MyGameCoordinator, MyGameViewController>()
            .environmentObject(MyGameCoordinator())
            .frame(width: 375, height: 812)
            .fixedSize()
        
        #endif
        
    }
    
}

struct OctopusKitQuickStartView_Previews: PreviewProvider {
    static var previews: some View {
        Text("See the TitleUI preview.")
    }
}