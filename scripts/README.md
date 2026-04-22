# Publication Import

Rebuild the publication Markdown files from a BibTeX source with:

```powershell
& 'C:\Ruby34-x64\bin\ruby.exe' .\scripts\import_publications_from_bib.rb --bib "C:\path\to\mybibfile.bib" --author "Feiran Zhao"
```

The importer:

- filters BibTeX entries whose author list contains `Feiran Zhao`
- writes generated Markdown files into `_publications/`
- removes older generated files before writing the new set
- keeps manually written publication files that do not contain `generated_by_bib_import: true`

