INACTIVE_TIME:0D00:10;
LAST_ACTIVE:.z.p;
INACTIVE_CHECK_TIME_MS:30*1e3;

endifinactive:{
  if[INACTIVE_TIME<.z.p-LAST_ACTIVE;-1"Exiting due to inactivity . . .";exit 0];
 };

.z.ts:{
  endifinactive[];
 };
