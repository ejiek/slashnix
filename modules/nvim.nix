{
  config,
  pkgs,
  home-manager,
  ...
}:

{
  home.sessionVariables = {
    EDITOR = "nvim";
  };

  programs.neovim = {
    enable = true;
    viAlias = true;
    vimAlias = true;
    vimdiffAlias = true;
    extraConfig = ''
      " Show current line and distance from it
      set rnu
      set nu

      " Tabbulation
      set autoindent   " Indent according to previous line.
      set expandtab
      set tabstop=2
      set shiftwidth=2

      " Show tabs and trailing whitespace
      set list
      set listchars=tab:▸\ ,trail:·

      set viminfo='10,\"100,:20,%,n~/.viminfo

      " Better window navigation
      nnoremap <C-h> <C-w>h
      nnoremap <C-j> <C-w>j
      nnoremap <C-k> <C-w>k
      nnoremap <C-l> <C-w>l
      " Split vetically with ctrl+| and horizontally with ctrl+/
    '';
    plugins = with pkgs.vimPlugins; [
      {
        plugin = airline;
        config = ''
          let g:airline_powerline_fonts = 1
        '';
      }
      copilot-vim
      {
        plugin = gruvbox-community;
        config = ''
          set termguicolors
          colorscheme gruvbox
          set background=light
        '';
      }
      vim-nix
      yankring
      {
        plugin = telescope-nvim;
        config = ''
          let g:telescope_previewer = 'bat'
          let mapleader = "\<Space>"
          nnoremap <leader>ff <cmd>Telescope find_files<cr>
          nnoremap <leader>fg <cmd>Telescope live_grep<cr>
          nnoremap <leader>fb <cmd>Telescope buffers<cr>
          nnoremap <leader>fh <cmd>Telescope help_tags<cr>
        '';
      }
      nvim-treesitter
      vim-devicons
      vim-fugitive
      # vim-rhubarb
      vim-signify
      vim-startify
    ];
  };

  home.packages = with pkgs; [
    # telescope dependencies
    bat
    fd
    fzf
    ripgrep
  ];
}
