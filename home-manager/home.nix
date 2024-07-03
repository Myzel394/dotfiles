{ lib, config, pkgs, ... }:

let
    take = a: b: if a == "" then b else a;
    username = builtins.getEnv "USER";
# minimal, full
    variant = take builtins.getEnv "NIX_HOME_MANAGER_VARIANT" "full";
    isMacos = (builtins.elemAt (builtins.elemAt (builtins.split ".+-(.+)" builtins.currentSystem) 1) 0) == "darwin";
    isLinux = !isMacos;
in {
# Home Manager needs a bit of information about you and the paths it should
# manage.
    home.username = username;
    home.homeDirectory = if isMacos then "/Users/${username}" else "/home/${username}";

# This value determines the Home Manager release that your configuration is
# compatible with. This helps avoid breakage when a new Home Manager release
# introduces backwards incompatible changes.
#
# You should not change this value, even if you update Home Manager. If you do
# want to update the value, then make sure to first check the Home Manager
# release notes.
    home.stateVersion = "23.11"; # Please read the comment before changing.

# The home.packages option allows you to install Nix packages into your
# environment.
        home.packages = with pkgs; [
# # Adds the 'hello' command to your environment. It prints a friendly
# # "Hello, world!" when run.
# pkgs.hello
# gcc
    openssl
        pkg-config
        darwin.apple_sdk.frameworks.Security
        coreutils
        git
        zsh
        neovim
        curl
        zip
        xz
        unzip

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
        crystal

        numbat

        (python3.withPackages (python-pkgs: [
           python-pkgs.libtmux
           python-pkgs.pip
           python-pkgs.requests
        ]))

        nodejs_22
        gtrash

# # It is sometimes useful to fine-tune packages, for example, by applying
# # overrides. You can do that directly here, just don't forget the
# # parentheses. Maybe you want to install Nerd Fonts with a limited number of
# # fonts?
# (pkgs.nerdfonts.override { fonts = [ "FantasqueSansMono" ]; })

# # You can also create simple shell scripts directly inside your
# # configuration. For example, this adds a command 'my-hello' to your
# # environment:
# (pkgs.writeShellScriptBin "my-hello" ''
#   echo "Hello, ${config.home.username}!"
# '')
    ] ++ (
        if variant == "full" then with pkgs; [
            numbat
            imagemagick
            conda
        ] else []
    ) ++ (
        if isLinux then with pkgs; [
            cryptsetup   
        ] else []
    );

# Home Manager is pretty good at managing dotfiles. The primary way to manage
# plain files is through 'home.file'.
    home.file = {
# # Building this configuration will create a copy of 'dotfiles/screenrc' in
# # the Nix store. Activating the configuration will then make '~/.screenrc' a
# # symlink to the Nix store copy.
# ".screenrc".source = dotfiles/screenrc;

# # You can also set the file content immediately.
# ".gradle/gradle.properties".text = ''
#   org.gradle.console=verbose
#   org.gradle.daemon.idletimeout=3600000
# '';
    };

# Home Manager can also manage your environment variables through
# 'home.sessionVariables'. These will be explicitly sourced when using a
# shell provided by Home Manager. If you don't want to manage your shell
# through Home Manager then you have to manually source 'hm-session-vars.sh'
# located at either
#
#  ~/.nix-profile/etc/profile.d/hm-session-vars.sh
#
# or
#
#  ~/.local/state/nix/profiles/profile/etc/profile.d/hm-session-vars.sh
#
# or
#
#  /etc/profiles/per-user/myzel394/etc/profile.d/hm-session-vars.sh
#
    home.sessionVariables = {
# EDITOR = "emacs";
        EDITOR = "nvim";
    };

# Let Home Manager install and manage itself.
    programs.home-manager.enable = true;

    nixpkgs.config.allowUnfree = true;
}
