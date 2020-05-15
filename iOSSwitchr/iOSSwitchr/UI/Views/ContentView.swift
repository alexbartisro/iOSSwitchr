//
//  ContentView.swift
//  iOSSwitchr
//
//  Created by alexandru.bartis on 13/05/2020.
//  Copyright © 2020 Alex Bartis. All rights reserved.
//

import SwiftUI

struct ContentView: View {
    @EnvironmentObject private var settings: Settings

    var body: some View {
        VStack {
            Text("First disable Safari from your device")
            PlayerView()
            Spacer()
            Text("Select your default browser:")
            Picker(selection: $settings.defaultBrowser, label: EmptyView()) {
                ForEach(self.settings.browsers, id:\.name) {
                    Text($0.name).tag($0)
                }
            }.labelsHidden()
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView().environmentObject(Settings())
    }
}
