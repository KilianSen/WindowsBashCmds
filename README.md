# Windows Bash Commands

Add common Bash/Linux commands to your Windows environment (CMD and PowerShell) with simple shims.

## Commands Included

- `ls` / `ll` (alias to `dir`)
- `grep` (PowerShell-backed search)
- `touch` (create/update files)
- `rm` (robust remove with `-rf` support)
- `cp` / `mv` / `cat` / `pwd` / `clear` / `man`
- `sudo` (Detects shell and elevates correctly)
- `ps` / `top` / `kill`
- `df` / `du` / `head` / `tail` / `diff` / `find`
- `ifconfig` / `uptime` / `which` / `sleep`

## One-Line Remote Install (No Clone Needed)

*It is always recommended to inspect remote scripts before running them.*

### PowerShell
```powershell
irm https://raw.githubusercontent.com/KilianSen/WindowsBashCmds/main/bootstrap.ps1 | iex
```

### Command Prompt (CMD)
```batch
powershell -c "irm https://raw.githubusercontent.com/KilianSen/WindowsBashCmds/main/bootstrap.ps1 | iex"
```
*(Replace `KilianSen` with your GitHub username)*

This command downloads the latest version of `WindowsBashCmds` to your home directory (`~/.windows-bash-cmds`) and sets it up for you.

## Local Install (If Cloned)

Simply run `install.bat` in the repository root:

## Features

### Help and Identification
Every command is identifiable as part of this suite. Use `-h` or `--help` to see usage:
```batch
ls -h
rm -h
sudo -h
```

### Updating
The updater is automatically added to your PATH. Run it anytime to get the latest shims:
```batch
update-bashcmds
```

### Uninstallation
The uninstaller is automatically added to your PATH. Run it anytime to revert all changes:
```batch
uninstall-bashcmds
```

## How it works

The installer adds the `bin/` directory to your user's `PATH`. It also removes conflicting default aliases from your PowerShell `$PROFILE` (like `ls` or `rm`) so that these custom implementations take precedence.
