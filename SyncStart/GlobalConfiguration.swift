//
//  GlobalConfiguration.swift
//  SyncStart
//
//  Created by 砚渤 on 2024/1/30.
//

import SwiftUI

struct Configuration {
    enum OptionKeys: String, CaseIterable {
        case UserName, Port, Host, RemotePath, LocalPath
    }
    
    static let OptionKeysDict: [OptionKeys: String] = [
        OptionKeys.UserName: "UserName",
        OptionKeys.Port: "Port",
        OptionKeys.Host: "Host",
        OptionKeys.RemotePath: "RemotePath",
        OptionKeys.LocalPath: "LocalPath"
    ]
    
    typealias RuntimeConfiguration = [OptionKeys: String]
    
    static func getEmptyConfiguration() -> RuntimeConfiguration {
        var result: RuntimeConfiguration = [:]
        for optionKey in OptionKeys.allCases {
            result[optionKey] = ""
        }
        return result
    }
}

struct GlobalConfiguration {
    
    var appPreferences: UserDefaults
    
    
    init() {
        self.appPreferences = UserDefaults()
    }
    
    func getOptionValue(key: Configuration.OptionKeys) -> String? {
        return self.appPreferences.string(forKey: Configuration.OptionKeysDict[key]!)
    }
    
    func setOptionValue(key: Configuration.OptionKeys, value: String) {
        self.appPreferences.set(value, forKey: Configuration.OptionKeysDict[key]!)
    }
    
    func getConfiguration() -> Configuration.RuntimeConfiguration {
        var result: Configuration.RuntimeConfiguration = Configuration.getEmptyConfiguration()
        for optionKey in Configuration.OptionKeys.allCases {
            result[optionKey] = self.getOptionValue(key: optionKey)
        }
        return result
    }
    
    func setConfiguration(_ value: Configuration.RuntimeConfiguration) {
        for (key, value) in value {
            self.setOptionValue(key: key, value: value)
        }
    }
}

