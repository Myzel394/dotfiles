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
        yq
        ijq
        curl
        delta
        tldr
        yt-dlp

        age
        sox
        gnupg

        cargo

        gtrash
        atuin

        diffnav
    ] else []
    ) ++ (
    if withGUI then [
        # nerdfonts.override { fonts = ["JetBrainsMono"]; }
	kitty
        neovide
        keepassxc
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
        go

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

