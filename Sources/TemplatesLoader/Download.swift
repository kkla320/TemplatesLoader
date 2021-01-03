//
//  File.swift
//  
//
//  Created by Kevin Klaebe on 03.01.21.
//

import ArgumentParser
import ShellOut
import Files
import Foundation

struct Download: ParsableCommand {
    private var repositoryUrl: URL {
        return URL(string: "https://github.com/kkla320/Templates.git")!
    }
    
    func run() throws {
        if Folder.current.containsSubfolder(named: "Templates") {
            try shellOut(to: .gitClone(url: repositoryUrl))
            return
        }
        
        try shellOut(to: .gitCheckout(branch: "master"))
        try shellOut(to: .gitPull())
    }
}
