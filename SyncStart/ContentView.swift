//
//  ContentView.swift
//  SyncStart
//
//  Created by 砚渤 on 2024/1/30.
//

import SwiftUI

struct ContentView: View {
    @State var configuration = GlobalConfiguration().getConfiguration()
    
    var body: some View {
        PreferenceView(runtimeConfiguration: $configuration)
        .padding()
    }
}

#Preview {
    ContentView()
}
