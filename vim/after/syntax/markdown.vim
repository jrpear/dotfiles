" account for front matter for static site generators; from https://tung.github.io/posts/toml-syntax-highlighting-for-zola-front-matter-in-vim/

unlet b:current_syntax
syntax include @Toml syntax/toml.vim
syntax region tomlFrontMatter start=/\%^+++$/ end=/^+++$/ contains=@Toml
syntax include @Yaml syntax/yaml.vim
syntax region yamlFrontMatter start=/\%^---$/ end=/^---$/ contains=@Yaml
