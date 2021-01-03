//
//  File.swift
//  
//
//  Created by Kevin Klaebe on 03.01.21.
//

import Foundation
import ArgumentParser
import Files

struct Remove: ParsableCommand {
    @Argument() private var group: String
    @Argument() private var template: String
    @Option() private var templateType: TemplateTypes
    
    func run() throws {
        try Folder(path: "~/Library/Developer/Xcode/Templates")
            .subfolder(named: templateType.folderName)
            .subfolder(named: group)
            .subfolder(named: "\(template).xctemplate")
            .delete()
    }
}

enum TemplateTypes: String, ExpressibleByArgument {
    case file
    case project
    
    var folderName: String {
        switch self {
        case .file:
            return "File Templates"
        case .project:
            return "Project Templates"
        }
    }
    
    init?(argument: String) {
        guard let templateType = TemplateTypes(rawValue: argument) else {
            return nil
        }
        self = templateType
    }
}
