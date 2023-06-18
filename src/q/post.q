killserver:{[]
  res:value system"bash ../sh/killserver.sh ",SERVER_PROCESS_ID;
  $[res;
    -1"Killed background server process with PID: ",SERVER_PROCESS_ID;
    -1"Could not kill background server process with PID: ",SERVER_PROCESS_ID
  ];
 };

post:{[]
  cls[];

  killserver[];

  -1"\nThank you for playing!\n";
  exit 0;
 };
