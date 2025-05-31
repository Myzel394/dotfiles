{ pkgs, withGUI, variant, ... }: 
let
    diffnav = (import ./diffnav.nix) { inherit pkgs; };
in
    with pkgs; [
        openssl
        pkg-config
        coreutils
        git
        zsh
        neovim
        wget
        curl
        zip
        xz
        gnumake
        gcc
        unzip
        tmux
    ] ++ (
    if (variant == "full" || variant == "minimal") then with pkgs; [
        bat
        btop
        hexyl
        fzf
        fd
        fselect
        ripgrep
        eza
        jq
        ijq
        curl
        delta
        tldr
        yt-dlp

        age
        sox
        gnupg

        cargo


        dive
        gtrash
        atuin
        gnome-tweaks

        diffnav
        bat-extras.prettybat
        bat-extras.batwatch
        bat-extras.batpipe
        bat-extras.batman
        bat-extras.batgrep
        bat-extras.batdiff
        exiftool
        flac
        silicon

        mosh
        monero-gui
        exodus
        electrum
        libsecret
        wl-clipboard
        subtitleedit
        amberol
        mediainfo
        mediainfo-gui
        tor-browser
        tenacity
        libreoffice-qt6
        anki
        telegram-desktop
        picard
        obs-studio
        vscode
        mpv
        nextcloud-client
        easytag
        wxhexeditor
        element-desktop
        bruno
        jetbrains.clion
        evince
        virtualbox
    ] else []
    ) ++ (
    if withGUI then [
        kitty
        neovide
        keepassxc
        ghostty

        brave
        firefox
        cinny-desktop
        feishin
        element-desktop
        bitwarden-desktop
        pulseeffects-legacy
        plex
        google-chrome
        veracrypt
        jellyfin-media-player
        endeavour
        plex-desktop
        protonmail-desktop
        mullvad-vpn
        makemkv
        gnome-pomodoro
        mkvtoolnix
        handbrake

        wineWowPackages.stable
        winetricks
    ] else []
    ) ++ (
    if variant == "full" then with pkgs; [
        numbat
        imagemagick
        # conda
        typst
        ansible
        cloudflared
        wireguard-tools
        csharp-ls
        go
        signal-desktop
        micromamba

        (python312.withPackages (p: with p; [
            libtmux
            yq
        ]))

        nodejs_20

        # Docker
        colima

        neovim
        tree-sitter

        # Audio conversion
        lame
        sox
        mediainfo
        ffmpeg
    ] else []
    ) ++ (
    if pkgs.stdenv.isLinux then with pkgs; [
        cryptsetup   
    ] else if pkgs.stdenv.isDarwin then with pkgs; [
        darwin.apple_sdk.frameworks.Security
        coreutils
        findutils
        gnused
        libtool
    ] else []
    )

