---
title: Run your nanoc site on Github Pages
---

Github Pages FTW
======

[Nanoc](http://nanoc.stoneship.org/) is a fantastic cool
for generating sites, and [github:pages](http://pages.github.com/)
is a fantastic low-maintenance way to host your static html site.

Can we get them together?  I think we can.

First, set up a site as usually:

    gem install nanoc 
    nanoc create_site my-site
    cd my-site

Make a `.rvmrc` and `Gemfile` if that floats your boat. I generally
add `nanoc`, `kramdown`, and `adsf` to the `Gemfile` to get started.

Create a [new github repo](https://github.com/repositories/new) if necessary 
to house your `nanoc` site (let's call it `your-repo`?), follow 
the steps, but before committing, your
`.gitignore` should include the `output` directory. Push to github (`origin`),
and let's make some biscuits.

    rm -rf output
    echo 'output' >> .gitignore
    git add . # NOT your output/ directory!
    git commit -m "boom"
    git remote add origin git@github.com:you/your-repo.git
    git push -u origin master

Having removed your output directory, clone your repo into it. Yes, this is
a little dirty. Once that's done, create an orphan branch called `gh-pages`.

    git clone git@github.com:you/your-repo.git output && cd output
    git checkout --orphan gh-pages
    git rm -rf .

Now you have a clean workspace. Back out into the parent directory, and
generate the site:

    cd .. && nanoc

Now your `gh-sites` branch, tucked away in the ignored `output/` directory
contains the compiled site.  The only thing left to do is push it to 
github:

    cd output
    git add .
    git commit -m "we are go for launch."
    git push -u origin gh-pages

After a few minutes, you should be able to hit
[http://you.github.com/your-repo/](#) and see the site you just built.

Neat, huh?

Because it's something of a pain to deploy this way every time, you can
put in place a [deploy
script](https://github.com/bvandgrift/nanoc-pages-demo/blob/master/deploy.sh) 
to make life a little easier:

    #!/usr/bin/env bash

    echo $1

    if [[ -z $1 ]]; then
      echo "usage: deploy \"commit message\""
    else
      echo "Deploying with commit message: $1"

      cd output
      git add .
      git commit -am "$1"
      git push

      echo "DONE."
    fi

Of course, it's also to have a [bootstrap script] for when you pull your repo
down to another file system, but I'll leave that as an exercies for the reader.




