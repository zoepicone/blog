# blog

A personal script to create html blogposts from Pandoc markdown files. Kinda 
hardcoded because, again, it's just for my own convenience.

## Usage

Pandoc is required to be installed and should be available in your package manager of choice.

Requires all markdown files to be in a directory inside the current 
directory, alongside a stylesheet named style.css. The table of contents will be made in the current directory.

```bash
bundle install
ruby blog.rb path/
```
