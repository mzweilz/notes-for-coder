## Rust
Rust Analyzer + Rust

Rust Analyzer设置：打开inlayHint等。

### 颜色设置
setting->(search)colorcustom->workbench: color customizations

setting.json
```
{
    "git.ignoreLegacyWarning": true,
    "rust-analyzer.server.path": "/home/mengze.wmz/.cargo/bin/rust-analyzer",
    "rust-analyzer.cargoRunner": null,
    "go.goroot": "/usr/local/go",
    "go.gopath": "/home/mengze.wmz/go",
    //第三方库代码提示
    "go.inferGopath": true,
    "go.formatTool": "goreturns",
    //自动完成未导入的包
    "go.autocompleteUnimportedPackages": true,
    "go.gocodePackageLookupMode": "go",
    "go.gotoSymbol.includeImports": true,
    "go.docsTool": "gogetdoc",
    "go.useCodeSnippetsOnFunctionSuggest": true,
    "go.useCodeSnippetsOnFunctionSuggestWithoutType": true,
    "go.useLanguageServer": true,
    "[go]": { 
        "editor.insertSpaces": false,
        "editor.formatOnSave": true, 
        "editor.codeActionsOnSave": { 
            "source.organizeImports": true, 
        },    // Optional: Disable snippets, as they conflict with completion ranking.    "editor.snippetSuggestions": "none", 
    },
    "[go.mod]": { 
        "editor.formatOnSave": true, 
        "editor.codeActionsOnSave": { 
            "source.organizeImports": true, 
        },
    },
    "go.trace.server": "verbose", 
    "gopls": { 
        // Add parameter placeholders when completing a function. 
       "usePlaceholders": false, 
       // If true, enable additional analyses with staticcheck. 
       // Warning: This will significantly increase memory usage.   "staticcheck": false, 
    },
    "go.languageServerFlags": [ 
        "-remote=auto", "-logfile=auto", "-debug=:0", "-rpc.trace", 
    ],
    "workbench.editorAssociations": {
        "*.ipynb": "jupyter.notebook.ipynb"
    },
    "plantuml.commandArgs": [
        {
            "plantuml.render": "PlantUMLServer",
            "plantuml.server": "https://www.plantuml.com/plantuml"
        }
    ],
    "go.installDependenciesWhenBuilding": true,
    "go.alternateTools": {
    "go-outline": "go-outline"
    },
    "rust-analyzer.completion.privateEditable.enable": true,
    "rust-analyzer.inlayHints.bindingModeHints.enable": true,
    "rust-analyzer.inlayHints.closureReturnTypeHints.enable": "always",
    "rust-analyzer.inlayHints.reborrowHints.enable": "always",
    "rust-analyzer.lens.references.adt.enable": true,
    "rust-analyzer.lens.references.enumVariant.enable": true,
    "rust-analyzer.lens.references.method.enable": true,
    "rust-analyzer.lens.references.trait.enable": true,
    "rust-analyzer.restartServerOnConfigChange": true,
    "editor.inlayHints.enabled": true,
    "rust-analyzer.inlayHints.lifetimeElisionHints.useParameterNames": true,
    "window.zoomLevel": 1,
    "workbench.colorCustomizations": {
        "editorInlayHint.foreground": "#b0afafda",
        "editorInlayHint.background": "#2f2f2faf"
    }
}
```
