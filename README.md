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
