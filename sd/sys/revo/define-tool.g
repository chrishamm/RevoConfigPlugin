; verify parameters
if !exists(param.S)
  abort "Missing S parameter (nozzle diameter)"

var highFlow = exists(param.H) && (param.H != 0)
var hardened = exists(param.O) && (param.O != 0)

; check if the tool must be selected again after redefinition
var selectTool = state.currentTool == 0

; a float renders with seven decimals, so derive the diameter text from integer hundredths
var whole = floor(param.S)
var frac = floor(param.S * 100 + 0.5) - var.whole * 100
var diameter = var.whole ^ "." ^ ((mod(var.frac, 10) == 0) ? floor(var.frac / 10) : var.frac)

; recreate T0
M563 P0 D{global.revoExtruder} H{global.revoHeater} F{global.revoFan} S{"Revo " ^ (var.hardened ? "ObXidian " : "") ^ (var.highFlow ? "HF " : "") ^ "Nozzle " ^ var.diameter ^ "mm"}
G10 P0 X0 Y0 Z0
M568 P0 R0 S0

; update the nozzle configuration
set global.nozzleDiameter = param.S
set global.nozzleHighFlow = var.highFlow
set global.nozzleHardened = var.hardened

; make this configuration persistent unless it's being restored on start (R parameter)
if !exists(param.R)
  echo >"revo/restore-tool.g" "M98 P""revo/define-tool.g"" S" ^ var.diameter ^ " H" ^ (var.highFlow ? 1 : 0) ^ " O" ^ (var.hardened ? 1 : 0) ^ " R1"

; select it again if necessary
if var.selectTool
  T0
  M703
