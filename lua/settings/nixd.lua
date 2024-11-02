local opts = {
  settings = {
    nixd = {
      formatting = {
        command = { "nixfmt" },
      },
      -- Not required normally, given below for reference
      -- nixpkgs = {
      --   expr = '(builtins.getFlake "/home/lr/dotfiles").inputs.nixpkgs { }',
      -- },
      -- For options autocompletion, you can specify a flake and a configuration name for nixos, home-manager, nix-darwin, etc
      options = {
      --   nixos = {
      --     -- Replace with your flake's absolute path and change confName to the name of the nixOS configuration
      --     expr = '(builtins.getFlake "/home/user/dotfiles").nixosConfigurations.confName.options',
      --   },
      --   home_manager = {
      --     -- Replace with your flake's absolute path and change user@confName to the name of the home-manager configuration
      --     expr = '(builtins.getFlake "/home/user/dotfiles").homeConfigurations."user@confName".options',
      --   },
      },
    },
  },
}

return opts
