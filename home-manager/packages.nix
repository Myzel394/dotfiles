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
        curl
        zip
        xz
        unzip

        crystal
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
        tmux

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
        sops
        ansible
        cloudflared
        wireguard-tools
        go

        # Audio conversion
        lame
        sox
        mediainfo

        antlr

        (pkgs.python311.withPackages (python-pkgs: [
          python-pkgs.libtmux
        ]))

        nodejs_20
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

