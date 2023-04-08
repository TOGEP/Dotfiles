all: init link nvim

init:
	./script/init.sh
	echo "init.sh done"

link:
	./script/link.sh
	echo "link.sh done"

.PHONY: nvim
nvim:
	./script/nvim.sh
	echo "nvim.sh done"
