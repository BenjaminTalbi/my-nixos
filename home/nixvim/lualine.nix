{
  programs.nixvim = {
    plugins.lualine = {
      enable = true;

      settings = {
        globalstatus = true;
        sections = {
          lualine_c = [
            {
              __unkeyed-1 = "filename";
              path = 1;
            }
          ];
        };
      };
    };
  };
}
