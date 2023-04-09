# dotfiles

![macOS](https://github.com/TOGEP/dotfiles/actions/workflows/macOS.yml/badge.svg)
![ubuntuOS](https://github.com/TOGEP/dotfiles/actions/workflows/ubuntuOS.yml/badge.svg)

## install
```bash
$ cd ~ && git clone https://github.com/TOGEP/dotfiles.git
$ cd dotfiles && make all
```

## copilot.vimを使う場合  
vimのプラグイン`copilot.vim`を使う場合はnodejsが必要となる
```bash
$ anyenv install nodenv
$ nodenv install *version*
$ nodenv rehash
$ nodenv global *version*
```
