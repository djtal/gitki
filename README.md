
## GitKi ##


Simple wiki using Git and Mardown

The pitch is simple

Your write your file in mardown version them with git. And then gitki take all that markdonw and generate a static site in just plain html(with some js or css).



## Usage ##

### Create a new gitki wiki.

```bash
  $ gitki create
```

Note : you can do it by hand it just an directory initilaized with a fresh git version

### Generate the site

In your project

```bash
  $ gitki generate
```

This will create a site directory with your site. serve it directly with your prefered web server and voila.

Options are :
* --from path_to_source_files : override source file path
* --to path_to_site : generate site to another location
* --render render_name : use another render to generate your site

### List available render

```bash
  $ gitki themes
```

## FF aka Futur Feature  ##

Maybe they will be or not

* manage intern link with [[page_name | filename]]
* log (to STDOUT) important informations when generating site
* better history
* better index
* add breadcrump based on folders
* add new wiki creation
* add a last modifed page with diff from last week for all page (and diff quantifier like +++ & --- on github)
* basic seo rule like page title and maybe some meta keyword
* anchor for h2 and h3 to work with toc
* search page based on some js
