ANSIBLE_PLAYBOOK:= HOMEBREW_CASK_OPTS="--appdir=/Applications" ansible-playbook -i .inventory

.PHONY: all
all: xdg-config ansible-playbook vscode


.PHONY: ansible-playbook
ansible-playbook: ansible
	cd ansible; $(ANSIBLE_PLAYBOOK) playbook.yml


XDG_DATA_HOME=$(HOME)/.local/share
XDG_CONFIG_HOME=$(HOME)/.config
XDG_CACHE_HOME=$(HOME)/.cache

.PHONY: xdg-config
xdg-config:
	mkdir -p ${XDG_DATA_HOME}
	mkdir -p ${XDG_CACHE_HOME}
	ln -fns $(shell pwd) ${XDG_CONFIG_HOME}


.PHONY: homebrew
homebrew:
ifeq ($(shell type brew 2> /dev/null),)
	/usr/bin/ruby -e \
"$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/master/install)"
endif


VSCODE_USERDIR=~/Library/Application\ Support/Code/User

.PHONY: vscode
vscode:
	if [ -e $(VSCODE_USERDIR) -a ! -L $(VSCODE_USERDIR) ]; then\
  rm -rf $(VSCODE_USERDIR);\
fi
	ln -fns $(shell pwd)/vscode $(VSCODE_USERDIR)
