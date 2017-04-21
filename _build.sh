#!/bin/sh

Rscript -e "bookdown::render_book('index.Rmd', 'bookdown::gitbook')"
Rscript -e "bookdown::render_book('index.Rmd', 'bookdown::pdf_book')"
Rscript -e "bookdown::render_book('index.Rmd', 'bookdown::epub_book')"

git add --all
git commit -m "update book"
git push origin master
git checkout gh-pages
git merge master
git commit -m "update book"
git push origin gh-pages
git checkout master
