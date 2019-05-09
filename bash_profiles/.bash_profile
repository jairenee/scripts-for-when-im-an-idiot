# .bash_profile

# Login and non-login shells should be identical
if [ -f ~/.bashrc ]; then
    # shellcheck source=/dev/null
	BPRSOURCED=true && . ~/.bashrc
fi
