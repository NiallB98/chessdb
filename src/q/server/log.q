log_info:{
  -1"INFO:  ",x;
 };

log_warn:{
  -1"WARN:  ",x;
 }

log_error:{
  -1"ERROR: ",x;
 };

log_debug:{
  if[DEBUG;-1"DEBUG: ",x];
 };
