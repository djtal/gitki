
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

* more usage of thor thor can be use as main workflow to create site skeleton
* manage intern link with [[page_name | filename]]
* log (to STDOUT) important informations when generating site
* better history
* allow disabling history generation
* better index
* allow disable index generation
* auto disbale history/index generation if files histroy/index are present src root
* use a config file for all site generation like site.rb or somthing like that
* add breadcrump based on folders
* add new wiki creation
* add a last modifed page with diff from last week for all page (and diff quantifier like +++ & --- on github)
* basic seo rule like page title and maybe some meta keyword
* search page based on some js
* use kbd tag for keyboyard shortcut display


## Search

* build an inverted index when generating site
* conssume this index with javascript on the client side

Usefull links on inverted index and full text search

* http://www.scribd.com/doc/15008618/4/Building-an-Inverted-Index
* http://rosettacode.org/wiki/Inverted_Index
