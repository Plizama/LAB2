%Constructor Filesystem
filesystem(Nombre, Usuarios, UsuarioActual, RutActual, Drives, Files, Directory, Trash,[Nombre, Usuarios, UsuarioActual, RutActual, Drives, Files, Directory, Trash]).

%Make Drive
makeDrive(LetterDrive, NameDrive, Capacity,[LetterDrive, NameDrive, Capacity]).

%F01: TDA system - constructor.
%creando la un nuevo sistema con nombre “NewSystem”
%system("NewSystem", S):-
system(Nombre, Sistema):-
    filesystem(Nombre, [],_,_,[],[],[],[], Sistema).
   
%F02: TDA system - addDrive.(FALTA)
%%creando la unidad C, con nombre “OS” y capacidad “1000000000 en el sistema “NewSystem”
%systemAddDrive(S, “C”,  “OS”, 10000000000, S2).
systemAddDrive(OriginalSystem, LetterDrive, NameDrive, Capacity,UpdateSystem):-
    