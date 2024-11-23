{
  programs.oh-my-posh = {
    enable = true;
    useTheme = "montys"; # montys
    # settings = builtins.fromTOML (builtins.readFile ./omp.toml);

  };
}
