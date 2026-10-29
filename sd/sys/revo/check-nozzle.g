; verify parameters
if !exists(param.S)
  abort "Missing S parameter (nozzle diameter)"

; check nozzle diameter
if global.nozzleDiameter != param.S
  abort "Incorrect nozzle diameter! Expected " ^ param.S ^ " but " ^ global.nozzleDiameter ^ " is configured."

; check the nozzle variant, but only against the parameters the caller passes
if exists(param.H) && ((param.H != 0) != global.nozzleHighFlow)
  abort "Incorrect nozzle! A " ^ ((param.H != 0) ? "high flow" : "standard flow") ^ " nozzle is required but " ^ (global.nozzleHighFlow ? "a high flow" : "a standard flow") ^ " one is configured."
if exists(param.O) && ((param.O != 0) != global.nozzleHardened)
  abort "Incorrect nozzle! " ^ ((param.O != 0) ? "A hardened ObXidian" : "A plain brass") ^ " nozzle is required but " ^ (global.nozzleHardened ? "an ObXidian" : "a brass") ^ " one is configured."
