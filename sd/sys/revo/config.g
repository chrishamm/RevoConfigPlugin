; create the nozzle configuration variables and define the last selected tool
global nozzleDiameter = 0.4
global nozzleHighFlow = false
global nozzleHardened = false
global revoExtruder = param.D
global revoHeater = param.H
global revoFan = param.F
M98 P"revo/restore-tool.g"
