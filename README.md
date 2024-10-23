# dotfiles

## stow

- install `stow`
- clone this repo to `~/dotfiles`
- cd to `~/dotfiles`
- run `stow .`

## tmux

- [config repo](https://github.com/gpakosz/.tmux)

```shell
cd ~
git clone https://github.com/gpakosz/.tmux.git
ln -s -f .tmux/.tmux.conf
# cp .tmux/.tmux.conf.local . # use .tmux.conf.local from dotfiles instead
```

## dependencies

```shell
- fzf
- bat
- tmux
- rbenv
- ruby-build
- eza
- zoxide
- [nano-syntax-highlighting](https://archlinux.org/packages/?name=nano-syntax-highlighting)
- [sesh](https://github.com/joshmedeski/sesh)
```
