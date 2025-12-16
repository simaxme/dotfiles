git config --global core.excludesfile ~/.gitignore
git config --global push.autosetupremote true
git config --global pull.rebase true

# Editor
git config --global core.editor nvim
git config --global merge.tool nvimdiff

# Signing
git config --global commit.gpgsign true
git config --global tag.gpgsign true
git config --global gpg.format ssh
git config --global user.signingkey ~/.ssh/signing_key.pub
