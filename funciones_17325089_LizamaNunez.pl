%TDA 
%CAPA CONSTRUCTORA
%Constructor Filesystem
filesystem(Nombre, Usuarios, UsuarioActual, RutActual, Drives, Files, Directory, Trash,[Nombre, Usuarios, UsuarioActual, RutActual, Drives, Files, Directory, Trash]).

%Constructor Drive
drive(Letter, NameDrive, Capacity,[Letter, NameDrive, Capacity]).

%Constructor Directory
directory(NameDirectory, CreatorUser, FechaCreacion, FechaModificacion, Atributos, Ubicacion,[NameDirectory,CreatorUser,FechaCreacion,FechaModificacion,Atributos,Ubicacion]).

%Constructor file
file(NameFile, Contenido,[NameFile, Contenido]).

%CAPA SELECTORA
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

getLetterDrive(Drive, Letter):-
    drive(Letter,_,_,Drive).

getFiles(SistemaActual, FilesActuales):-
    filesystem(_,_,_,_,_,FilesActuales,_,_,SistemaActual).

getContentFile(FileBuscado,ContentFile):-
    file(FileBuscado,ContentFile,_).

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

setListUsers(NewUser, OriginalUsers, UpdateUsers):-
    append(OriginalUsers, [NewUser], UpdateUsers).

setSystemNewUsers(OriginalSystem, UpdateUsers, UpdateSystem):-
    filesystem(NameSystem,_, UsuarioActual, RutaActual,Drives, Files, Directory, Trash,OriginalSystem),
    filesystem(NameSystem, UpdateUsers, UsuarioActual, RutaActual,Drives, Files, Directory, Trash, UpdateSystem).

setUserActual(NewUser, OriginalUser, UpdateUser):-
    append(OriginalUser, [NewUser], UpdateUser).

setSystemNewLogin(OriginalSystem, UpdateUser,UpdateSystem):-
    filesystem(NameSystem,Usuarios, _, RutaActual,Drives, Files, Directory, Trash,OriginalSystem),
    filesystem(NameSystem, Usuarios, UpdateUser, RutaActual,Drives, Files, Directory, Trash, UpdateSystem).

setSystemLogout(OriginalSystem,UpdateSystem):-
    filesystem(NameSystem,Usuarios, _, RutaActual,Drives, Files, Directory, Trash,OriginalSystem),
    filesystem(NameSystem, Usuarios,[], RutaActual,Drives, Files, Directory, Trash, UpdateSystem).


setSystemDriveActual(OriginalSystem, LetterDrive,UpdateSystem):-
    filesystem(NameSystem,Usuarios, UsuarioActual,_,Drives, Files, Directory, Trash,OriginalSystem),
    filesystem(NameSystem, Usuarios,UsuarioActual,[LetterDrive],Drives, Files, Directory, Trash, UpdateSystem).

setNewDirectory(NewDirectory, OriginalDirectory, UpdateDirectories):-
    append(OriginalDirectory, [NewDirectory], UpdateDirectories).

setSystemDirectories(OriginalSystem, UpdateDirectories,UpdateSystem):-
    filesystem(NameSystem,Usuarios, UsuarioActual,RutaActual,Drives, Files,_, Trash,OriginalSystem),
    filesystem(NameSystem, Usuarios,UsuarioActual,RutaActual,Drives, Files, UpdateDirectories, Trash, UpdateSystem).

setNewFile(NewFile,OriginalFile,UpdateFile):-
    append(OriginalFile,[NewFile],UpdateFile).

setSystemFiles(OriginalSystem, UpdateFile,UpdateSystem):-
    filesystem(NameSystem,Usuarios, UsuarioActual,RutaActual,Drives, _,Directory, Trash,OriginalSystem),
    filesystem(NameSystem, Usuarios,UsuarioActual,RutaActual,Drives, UpdateFile, Directory, Trash, UpdateSystem).

setNewTrash(NewTrash,OriginalTrash,UpdateTrash):-
    append(OriginalTrash,NewTrash,UpdateTrash).

setSystemTrash(OriginalSystem,UpdateTrash,UpdateSystem):-
    filesystem(NameSystem,Usuarios, UsuarioActual,RutaActual,Drives, Files,Directory, _,OriginalSystem),
    filesystem(NameSystem, Usuarios,UsuarioActual,RutaActual,Drives, Files, Directory, UpdateTrash, UpdateSystem).

    

%OTRAS CAPAS
%%
existe(Elemento, [Elemento|_]):- !.
existe(Elemento, [_|Resto]):-
    existe(Elemento, Resto).


eliminarUltimaUbicacion([_| []],[]).
eliminarUltimaUbicacion([Primero | Resto], [Primero | NewLista]):-
    eliminarUltimaUbicacion(Resto,NewLista).

listaLetter([], []).
listaLetter([[Nombre,_,_] | Resto], [Nombre | NuevaLista]) :-
    listaLetter(Resto, NuevaLista).
    
seleccionarPrimeraUbicacion([Elemento|_], Elemento).

%F01: TDA system - constructor.
system(Nombre, Sistema):-
    filesystem(Nombre, [],[],[],[],[],[],[], Sistema).
   
%F02: TDA system - addDrive.
systemAddDrive(OriginalSystem, LetterDrive, NameDrive, Capacity,UpdateSystem):-
    drive(LetterDrive,NameDrive,Capacity,NewDrive),
    getDrives(OriginalSystem, DrivesActuales),
    listaLetter(DrivesActuales,LetterActuales),
    \+member(LetterDrive,LetterActuales),
    setaddDrives(NewDrive, DrivesActuales, UpdateDrives),
    setSystemNewDrives(OriginalSystem, UpdateDrives, UpdateSystem).

%F03: TDA system - register.
systemRegister(OriginalSystem, NewUser,UpdateSystem):-
    getListUsers(OriginalSystem, OriginalUsers),
    \+member(NewUser,OriginalUsers),
    setListUsers(NewUser, OriginalUsers, UpdateUsers),
    setSystemNewUsers(OriginalSystem, UpdateUsers, UpdateSystem).

%F04: TDA system - login. (FALTA MISMO USUARIO).
systemLogin(OriginalSystem,UserLog,UpdateSystem):-
    getListUsers(OriginalSystem, OriginalListUsers),
    existe(UserLog,OriginalListUsers),
    getUserActual(OriginalSystem, OriginalUser),
    setUserActual(UserLog, OriginalUser, UpdateUser),
    setSystemNewLogin(OriginalSystem,UpdateUser,UpdateSystem).