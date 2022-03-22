{
  description = ''Wrapper for X11'';

  inputs.flakeNimbleLib.owner = "riinr";
  inputs.flakeNimbleLib.ref   = "master";
  inputs.flakeNimbleLib.repo  = "nim-flakes-lib";
  inputs.flakeNimbleLib.type  = "github";
  inputs.flakeNimbleLib.inputs.nixpkgs.follows = "nixpkgs";
  
  inputs.src-x11-master.flake = false;
  inputs.src-x11-master.owner = "nim-lang";
  inputs.src-x11-master.ref   = "master";
  inputs.src-x11-master.repo  = "x11";
  inputs.src-x11-master.type  = "github";
  
  outputs = { self, nixpkgs, flakeNimbleLib, ...}@deps:
  let 
    lib  = flakeNimbleLib.lib;
    args = ["self" "nixpkgs" "flakeNimbleLib" "src-x11-master"];
  in lib.mkRefOutput {
    inherit self nixpkgs ;
    src  = deps."src-x11-master";
    deps = builtins.removeAttrs deps args;
    meta = builtins.fromJSON (builtins.readFile ./meta.json);
  };
}