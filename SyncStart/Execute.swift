//
//  Execute.swift
//  SyncStart
//
//  Created by 砚渤 on 2024/1/30.
//

import Foundation
import SwiftExec

func fillTemplate (template: String, configuration: Configuration.RuntimeConfiguration) -> String {
    var result = template
    for (key, value) in configuration {
        result = result.replacingOccurrences(of: "{\(Configuration.OptionKeysDict[key]!)}", with: value)
    }
    return result
}

func execute(configuration: Configuration.RuntimeConfiguration, template: String = defaultScriptTemplate) async throws -> ExecResult {
    try DispatchQueue.main.asyncAndWait {
        try execBash("echo '\(fillTemplate(template: template, configuration: configuration))' | bash /dev/stdin")
    }
}
