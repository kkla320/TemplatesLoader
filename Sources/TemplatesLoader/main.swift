import ArgumentParser

struct TemplatesLoader: ParsableCommand {
    static var configuration = CommandConfiguration(
        subcommands: [
            Download.self,
            Add.self,
            List.self,
            Remove.self
        ])
}

TemplatesLoader.main()
