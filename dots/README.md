## Create symlinks with stow
```bash
stow -t ~ .
```
Remove symlinks:
```bash
stow -t ~ -D
```

## Set global .gitignore file
```sh
git config --global core.excludesfile ~/.gitignore
```