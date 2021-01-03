//
//  File.swift
//  
//
//  Created by Kevin Klaebe on 03.01.21.
//

import Foundation
import ArgumentParser
import Files

struct List: ParsableCommand {
    @Option() private var filter: ListFilter = .all
    @Flag() private var showAvailable: Bool = false
    
    func run() throws {
        let templates = showAvailable
            ? try Folder.current.subfolder(named: "Templates")
            : try Folder(path: "~/Library/Developer/Xcode/Templates")
        
        if filter == .files || filter == .all {
            try listFileTemplates(folder: templates)
        }
        if filter == .projects || filter == .all {
            try listProjectTemplates(folder: templates)
        }
    }
    
    private func listFileTemplates(folder: Folder) throws {
        print("File templates")
        do {
            let fileTemplates = try folder.subfolder(named: "File templates")
            try printTemplateTree(folder: fileTemplates)
        } catch let error as LocationError where error.reason != .missing {
            throw error
        } catch {
            print("└ No file templates")
        }
    }
    
    private func listProjectTemplates(folder: Folder) throws {
        do {
            print("Project templates")
            let projectTemplates = try folder.subfolder(named: "Project templates")
            try printTemplateTree(folder: projectTemplates)
        } catch let error as LocationError where error.reason != .missing {
            throw error
        } catch {
            print("└ No project templates")
        }
    }
    
    private func printTemplateTree(folder: Folder) throws {
        for group in folder.subfolders {
            let isLastGroup = folder.subfolders.last() == group
            print("\(isLastGroup ? "└" : "├") \(group.name)")
            for template in group.subfolders {
                let isLastTemplate = group.subfolders.last() == template
                print("\(isLastGroup ? " " : "│") \(isLastTemplate ? "└" : "├") \(template.nameExcludingExtension)")
            }
        }
    }
}

extension LocationErrorReason: Equatable {
    public static func == (lhs: LocationErrorReason, rhs: LocationErrorReason) -> Bool {
        switch (lhs, rhs) {
        case (.missing, .missing), (.emptyFilePath, .emptyFilePath), (.cannotRenameRoot, .cannotRenameRoot):
            return true
        case (.renameFailed(_), .renameFailed(_)):
            return true
        case (.moveFailed(_), .moveFailed(_)):
            return true
        case (.copyFailed(_), .copyFailed(_)):
            return true
        case (.deleteFailed(_), .deleteFailed(_)):
            return true
        case (.unresolvedSearchPath(_, _), .unresolvedSearchPath(_, _)):
            return true
        default:
            return false
        }
    }
}
