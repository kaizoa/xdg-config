ANSIBLE_PLAYBOOK:= HOMEBREW_CASK_OPTS="--appdir=/Applications" ansible-playbook -i .inventory

.PHONY: all
all: xdg-config ansible-playbook vscode


.PHONY: ansible-playbook
ansible-playbook: ansible
	cd ansible; $(ANSIBLE_PLAYBOOK) playbook.yml


XDG_CONFIG_HOME=$(HOME)/.config

.PHONY: xdg-config
xdg-config:
	if [ -e $(XDG_CONFIG_HOME) -a ! -L $(XDG_CONFIG_HOME) ]; then\
  rm -rf $(XDG_CONFIG_HOME);\
fi
	ln -fns $(shell pwd) ${XDG_CONFIG_HOME}


.PHONY: git
git: homebrew
ifeq ($(shell type git 2> /dev/null),)
	brew install git
endif


.PHONY: ansible
ansible: homebrew
ifeq ($(shell type ansible-playbook 2> /dev/null),)
	brew install ansible
endif


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
