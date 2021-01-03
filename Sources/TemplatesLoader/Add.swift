//
//  File.swift
//  
//
//  Created by Kevin Klaebe on 03.01.21.
//

import Foundation
import ArgumentParser
import Files

struct Add: ParsableCommand {
    func run() throws {
        try addFileTemplates()
        try addProjectTemplates()
    }
    
    private func addFileTemplates() throws {
        let fileTemplates = try Folder
            .current
            .subfolder(named: "Templates")
            .subfolder(named: "File Templates")
        
        let targetFileTemplates = try Folder(path: "~/Library/Developer/Xcode/Templates")
            .createSubfolderIfNeeded(withName: "File Templates")
        
        for group in fileTemplates.subfolders {
            let targetGroupFolder = try targetFileTemplates.createSubfolderIfNeeded(withName: group.name)
            
            for template in group.subfolders {
                if targetGroupFolder.containsSubfolder(named: template.name) {
                    try targetGroupFolder.subfolder(named: template.name).delete()
                }
                
                try template.copy(to: targetGroupFolder)
            }
        }
    }
    
    private func addProjectTemplates() throws {
        let fileTemplates = try Folder
            .current
            .subfolder(named: "Templates")
            .subfolder(named: "Project Templates")
        
        let targetFileTemplates = try Folder(path: "~/Library/Developer/Xcode/Templates")
            .createSubfolderIfNeeded(withName: "Project Templates")
        
        for group in fileTemplates.subfolders {
            let targetGroupFolder = try targetFileTemplates.createSubfolderIfNeeded(withName: group.name)
            
            for template in group.subfolders {
                if targetGroupFolder.containsSubfolder(named: template.name) {
                    try targetGroupFolder.subfolder(named: template.name).delete()
                }
                
                try template.copy(to: targetGroupFolder)
            }
        }
    }
}
