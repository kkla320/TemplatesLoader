//
//  File.swift
//  
//
//  Created by Kevin Klaebe on 03.01.21.
//

import Foundation
import ArgumentParser

enum ListFilter: String, ExpressibleByArgument {
    case files
    case projects
    case all
    
    init?(argument: String) {
        guard let filter = ListFilter(rawValue: argument) else {
            return nil
        }
        self = filter
    }
}
