**French version - English below**

# Slides de ma soutenance de thèse

Formalisation et étude de problématiques de scoring en risque de crédit
Inférence de rejet, discrétisation de variables et interactions, arbres de régression logistique

Thèse de Doctorat en Mathématiques et leurs interactions de l'Université de Lille, Spécialité Statistique  
Soutenue le ...  
Préparée au sein du Laboratoire Paul Painlevé, de l'Inria Lille  
Nord-Europe et de Crédit Agricole Consumer Finance.  
École doctorale Sciences pour l’Ingénieur  
Unité de recherche Équipe-projet MODAL


Les codes nécessaires à l'obtention de la majorité des résultats sur données simulées / UCI sont disponibles dans ce repo.  
Pour compiler les slides, il est nécessaire d'avoir [git](https://git-scm.com/) et une [distribution TeX](https://www.latex-project.org/get/).

J'utilise la fonction "Quick Build" de mon éditeur TeXmaker avec la commande suivante :
```bash
"pdflatex" -synctex=1 -interaction=nonstopmode %.tex|"biber" %|"pdflatex" -synctex=1 -interaction=nonstopmode %.tex|"biber" %|"pdflatex" -synctex=1 -interaction=nonstopmode %.tex|open %.pdf
```

Avec le mode "presentation" de la classe beamer, le thème a un fond noir, mes notes sont produites sur une deuxième moitié de l'écran. Avec le mode "handout", le thème a un fond blanc (pour l'impression), les slides sont dans leur état final, i.e. sans transition, et mes notes n'apparaissent pas.

Le fichier `soutenance.pdf` est ainsi obtenu dans le dossier `slides_soutenance`.

**English version - French above**

# My PhD defense

Formalization and study of statistical problems in Credit Scoring
Reject inference, discretization and pairwise interactions, logistic regression trees

PhD of Applied Mathematics from the University of Lille, Speciality Statistics  
Thesis defended on ...  
Prepared at Laboratoire Paul Painlevé, Inria Lille Nord-Europe and Crédit Agricole Consumer Finance.  
Doctoral School Sciences pour l’Ingénieur  
University Department Équipe-projet MODAL

The code to obtain all results on simulated / UCI data are made available in this repo.  
To compile the slides, [git](https://git-scm.com/) and a [TeX distribution](https://www.latex-project.org/get/) are needed.

I use the "Quick Build" function of TeXmaker with the following command:
```bash
"pdflatex" -synctex=1 -interaction=nonstopmode %.tex|"biber" %|"pdflatex" -synctex=1 -interaction=nonstopmode %.tex|"biber" %|"pdflatex" -synctex=1 -interaction=nonstopmode %.tex|open %.pdf
```

When the "presentation" option is set, the background is black and my notes show as a second screen on the right hand side of the screen. When the "handout" option is set, there is no transition, only the final "states" of each slide, which background is white and my notes are not displayed.

The file `soutenance.pdf` should be visible in the `slides_soutenance` folder.

## Credits

To make sure LaTeX packages are not loaded but not used, I used the Python [LaTeXpkges script](https://github.com/TarasKuzyo/LaTeXpkges) (MIT Licence).  
Feel free to clone / fork / star for your own work!
