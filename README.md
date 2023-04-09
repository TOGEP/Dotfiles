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

## iterm2の設定反映
```text
1. Press "command + ," to open the preferences window.
2. Select the "General" tab.
3. Select the "Preferences" tab.
4. Turn on "Load preference from a custom folder or URL".
5. Enter "~/dotfiles/iterm2/com.googlecode.iterm2.plist".
6. Restart iterm2 !
```

## 初回起動が必要なもの
- Alfred
- Karabiner-Elements
