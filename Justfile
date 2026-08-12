set shell := ["bash", "-uc"]

hostname := `
  if [[ "$(hostname)" == "localhost" ]] && [[ -n "$HOSTNAME" ]]; 
    then echo "$HOSTNAME"; 
  else 
    hostname; 
  fi
`
default: rebuild-nh

update input="":
    nix flake update {{ input }} --flake ./nix

rebuild:
    sudo nixos-rebuild switch --flake ./nix

rebuild-nh:
    #!/usr/bin/env bash
    if [[ "{{ hostname }}" == "azuki" ]]; then
      nix-on-droid switch --flake ./nix#azuki;
    else
      nh os switch ./nix
    fi

clean:
    sudo nh clean all

meta:
    nix flake metadata ./nix

history:
    nix profile history --profile /nix/var/nix/profiles/system

repl:
    nix repl ./nix

check:
    nix flake check ./nix

test-nix:
    nix-unit --flake ./nix#tests

format:
    treefmt
    stylua --allow-hidden ./

typecheck-lua:
    lua-language-server --check=./

test-lua:
    #!/usr/bin/env lua
    local T = require("lib.test")
    local dotfiles = os.getenv("HOME") .. "/dotfiles"
    local handle = io.popen("find " .. dotfiles .. " -name '*_spec.lua' -type f -not -path '*/.git/*'")
    if handle then
      for file in handle:lines() do
        local rel = file:match(dotfiles .. "/(.+)%.lua$")
        local mod = rel:gsub("/", ".")
        local spec = require(mod)
        spec(T)
      end
      handle:close()
    end
    T.run()

test-fish:
    #!/usr/bin/env bash
    for f in $(find .config/fish/lib -name '*.test.fish' -type f -not -path '*/.git/*'); do
      fish "$f" || exit 1
    done

stow apply="":
    #!/usr/bin/env bash
    if [[ 
      "{{ hostname }}" == "chocola" || 
      "{{ hostname }}" == "vanilla" || 
      "{{ hostname }}" == "coconut" 
    ]]; 
    then
      echo "Please use home-manager instead of stow"
    elif [[ "{{ apply }}" == "apply" ]]; then
      echo "Stowing..."
      stow .
    else
      echo "Simulating stow..."
      stow --simulate .
    fi

submodules:
    git submodule update --init --recursive

keychain:
    keychain --absolute --dir "$XDG_RUNTIME_DIR"/keychain ~/.ssh/{{ hostname }}:
