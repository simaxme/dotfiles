pacman -Qm | cut -d " " -f 1 | tee ./packages/aur.txt
pacman -Qne | cut -d " " -f 1 | tee ./packages/pacman.txt
