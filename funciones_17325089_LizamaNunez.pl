%TDA 
%CAPA CONSTRUCTORA
%
%Constructor Filesystem
filesystem(Nombre, Usuarios, UsuarioActual, RutActual, Drives, Files, Directory, Trash,[Nombre, Usuarios, UsuarioActual, RutActual, Drives, Files, Directory, Trash]).

%Constructor Drive
drive(Letter, NameDrive, Capacity,[Letter, NameDrive, Capacity]).

%CAPA SELECTORA.

getNameSystem(SistemaActual, NombreSistema):-
    filesystem(NombreSistema,_,_,_,_,_,_,_,SistemaActual).

getListUsers(SistemaActual, ListUsers):-
    filesystem(_,ListUsers,_,_,_,_,_,_,SistemaActual).

getUserActual(SistemaActual, UserActual):-
    filesystem(_,_,UserActual,_,_,_,_,_,SistemaActual).

getRutaActual(SistemaActual, RutaActual):-
    filesystem(_,_,_,RutaActual,_,_,_,_,SistemaActual).

getDrives(SistemaActual, DrivesActuales):-
    filesystem(_,_,_,_,DrivesActuales,_,_,_,SistemaActual).

getFiles(SistemaActual, FilesActuales):-
    filesystem(_,_,_,_,_,FilesActuales,_,_,SistemaActual).

getDirectory(SistemaActual, DirectoryActuales):-
    filesystem(_,_,_,_,_,_,DirectoryActuales,_,SistemaActual).

getTrash(SistemaActual, TrashActual):-
    filesystem(_,_,_,_,_,_,_,TrashActual,SistemaActual).
%CAPA MODIFICADORA

setaddDrives(NewDrive, OriginalDrives, UpdateDrives):-
    append(OriginalDrives, [NewDrive], UpdateDrives).

setSystemNewDrives(OriginalSystem, UpdateDrives, UpdateSystem):-
    filesystem(NameSystem, Usuarios, UsuarioActual, RutaActual,_, Files, Directory, Trash,OriginalSystem),
    filesystem(NameSystem, Usuarios, UsuarioActual, RutaActual,UpdateDrives, Files, Directory, Trash, UpdateSystem).

%OTRAS FUNCIONES
%Existe Letter Drive?
existeLetterDrive()


%F01: TDA system - constructor.
%creando la un nuevo sistema con nombre “NewSystem”
%system("NewSystem", S):-
system(Nombre, Sistema):-
    filesystem(Nombre,[],[],[],[],[],[],[],Sistema).


%F02: TDA system - addDrive.(FALTA member letter).
%%creando la unidad C, con nombre “OS” y capacidad “1000000000 en el sistema “NewSystem”
%systemAddDrive(S, “C”,  “OS”, 10000000000, S2).
%systemAddDrive(S, "C",  "OS", 10000000000, S2),
systemAddDrive(OriginalSystem, LetterDrive, NameDrive, Capacity,UpdateSystem):-
    drive(LetterDrive,NameDrive,Capacity,NewDrive),
    getDrives(OriginalSystem, DrivesActuales),
    \+member(LetterDrive,DrivesActuales),
    setaddDrives(NewDrive, DrivesActuales, UpdateDrives),
    setSystemNewDrives(OriginalSystem, UpdateDrives, UpdateSystem).

    