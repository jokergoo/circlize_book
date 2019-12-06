#!/bin/sh

Rscript -e "bookdown::render_book('index.Rmd', 'bookdown::gitbook')"

git add --all
git commit -m "update book"
git push origin master
git checkout gh-pages
git merge master
git commit -m "update book"
git push origin gh-pages
git checkout master
