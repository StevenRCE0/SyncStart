//
//  PreferenceView.swift
//  SyncStart
//
//  Created by 砚渤 on 2024/1/30.
//

import SwiftUI

struct PreferenceView: View {
    @Binding var runtimeConfiguration: Configuration.RuntimeConfiguration
    @State var runtimeError: LocalizedAlertError?
    let globalConfiguration = GlobalConfiguration()
    
    func optionFieldBindingConstructor(_ optionKey: Configuration.OptionKeys) -> Binding<String> {
        .init {
            runtimeConfiguration[optionKey] ?? ""
        } set: { value in
            runtimeConfiguration[optionKey] = value
        }
    }
    
    func errorBindingConstructor() -> Binding<Bool> {
        
        .init(
            get:{
                runtimeError != nil
            },
            set: { _ in
                runtimeError = nil
            }
        )
    }
    
    
    var body: some View {
        VStack {
            ForEach(Configuration.OptionKeys.allCases, id: \.rawValue) { optionKey in
                HStack {
                    Text(optionKey.rawValue)
                    TextField("Please enter \(optionKey.rawValue)", text: optionFieldBindingConstructor(optionKey))
                }
            }
            HStack {
                Button("save") {
                    globalConfiguration.setConfiguration(runtimeConfiguration)
                }
                Button("reload") {
                    runtimeConfiguration = globalConfiguration.getConfiguration()
                }
                Spacer()
                Button {
                    Task {
                        do {
                            _ = try await execute(configuration: runtimeConfiguration)
                        } catch {
                            runtimeError = LocalizedAlertError(error: error)
                        }
                    }
                } label: {
                    Image(systemName: "play")
                }
                .alert(isPresented: errorBindingConstructor(), error: runtimeError) {
                    Text("Okay")
                }
            }
        }
    }
}

#Preview {
    PreferenceView(runtimeConfiguration: .constant([:]))
}
