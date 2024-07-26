{ pkgs, withGUI, variant, ... }: 
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
        ijq
        curl
        delta
        tldr
        yt-dlp
        tmux

        age
        sox

        cargo

        gtrash
    ] else []
    ) ++ (
    if withGUI then with pkgs; [
        # nerdfonts.override { fonts = ["JetBrainsMono"]; }
    ] else []
    ) ++ (
    if variant == "full" then with pkgs; [
        numbat
        imagemagick
        conda
        typst
        sops

        (python3.withPackages (python-pkgs: [
           python-pkgs.libtmux
           python-pkgs.pip
           python-pkgs.requests
        ]))

        nodejs_22
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

