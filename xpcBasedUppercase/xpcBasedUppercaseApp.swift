//
//  xpcBasedUppercaseApp.swift
//  xpcBasedUppercase
//
//  Created by Anubhav Gain on 14/03/24.
//

import SwiftUI

@main
struct xpcBasedUppercaseApp: App {
    let xpcClient = XPCClient();
    var body: some Scene {
        WindowGroup {
            ContentView(xpcClient: xpcClient)
                .frame(minWidth: 500, maxWidth: 500, minHeight: 300, maxHeight: 300)
                .onReceive(NotificationCenter.default.publisher(
                    for: NSApplication.willTerminateNotification)) { _ in
                    // MARK: this is necessary if you want to avoid zombies
                    // in preview mode
                    xpcClient.close()
                }
        }
        .windowStyle(.hiddenTitleBar)
        .windowResizability(.contentSize)
    }
   }

