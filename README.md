# ledouxImport
Feuilles XSLT pour la transformations du catalogue Ledoux docx vers tei
## ledouxProfile
Ce dossier contient un profile personnalisé pour les TEI Stylesheets :
- cloner le repo `https://github.com/TEIC/Stylesheets`
- copier le dossier `ledouxProfile` dans `Stylesheets/profiles`
- lancer la commande `make install` dans le dossier `Stylesheets`
- lancer la transformation `docxtotei --profile=local input.docx output.xml`

## listObject.xsl
Seconde feuille de transformation. Elle crée les `<listObject/>`. 

## catalogue.docx
Les entrées du catalogues dans le document .docx doivent être stylées avec des niveaux de titres.
