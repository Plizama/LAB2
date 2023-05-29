%TDA 
%REPRESENTACIÓN

%Filesystem= Nombre(str) X Usuarios(list) X UsuarioLog(list) X RutaActual(List) X Drives(list) X Files(list) X Directory(list) X Trash(list) X FechadeCreacion (number) X NameSystemUpdate(str)
%Drives= Letter(str) X NameDrive(str) X Capacity(number) X NameUpdateDrive(str)
%Files = NameExtension(str) X Content(str) X NameFile(str)
%Directory= NameDirectory(str) X UsuarioCreador(list) X FechaCreacion(list) X FechaModificacion(list) X Atributos(list) X Ubicacion(list) X NameUpdateDirectory(list)
%Trash = Trash(list)

%CAPA CONSTRUCTORA
%Constructor Filesystem
filesystemFecha(Nombre, Usuarios, UsuarioActual, RutActual, Drives, Files, Directory, Trash,Fecha,[Nombre, Usuarios, UsuarioActual, RutActual, Drives, Files, Directory, Trash, Fecha]):-
    get_time(Fecha).

filesystem(Nombre, Usuarios, UsuarioActual, RutActual, Drives, Files, Directory, Trash, Fecha,[Nombre, Usuarios, UsuarioActual, RutActual, Drives, Files, Directory, Trash, Fecha]).



%Constructor Drive
drive(Letter, NameDrive, Capacity,[Letter, NameDrive, Capacity]).

%Constructor Directory
directory(NameDirectory, CreatorUser, FechaCreacion, FechaModificacion, Atributos, Ubicacion,[NameDirectory,CreatorUser,FechaCreacion,FechaModificacion,Atributos,Ubicacion]).

%Constructor file
file(NameFile, Contenido,[NameFile, Contenido]).

%CAPA SELECTORA
getNameSystem(SistemaActual, NombreSistema):-
    filesystem(NombreSistema,_,_,_,_,_,_,_,_,SistemaActual).

getListUsers(SistemaActual, ListUsers):-
    filesystem(_,ListUsers,_,_,_,_,_,_,_,SistemaActual).

getUserActual(SistemaActual, UserActual):-
    filesystem(_,_,UserActual,_,_,_,_,_,_,SistemaActual).

getRutaActual(SistemaActual, RutaActual):-
    filesystem(_,_,_,RutaActual,_,_,_,_,_,SistemaActual).

getDrives(SistemaActual, DrivesActuales):-
    filesystem(_,_,_,_,DrivesActuales,_,_,_,_,SistemaActual).

getLetterDrive(Drive, Letter):-
    drive(Letter,_,_,Drive).

getFiles(SistemaActual, FilesActuales):-
    filesystem(_,_,_,_,_,FilesActuales,_,_,_,SistemaActual).

getFecha(Fecha):-
    get_time(Fecha).
    
%Get contenido File
getContenidoFile(X, [[X,Contenido] | _],Contenido).
getContenidoFile(X, [ _ | Tail], Contenido) :-
    getContenidoFile(X, Tail, Contenido).


getDirectory(SistemaActual, DirectoryActuales):-
    filesystem(_,_,_,_,_,_,DirectoryActuales,_,_,SistemaActual).

getTrash(SistemaActual, TrashActual):-
    filesystem(_,_,_,_,_,_,_,TrashActual,_,SistemaActual).


%CAPA MODIFICADORA

setaddDrives(NewDrive, OriginalDrives, UpdateDrives):-
    append(OriginalDrives, [NewDrive], UpdateDrives).

setSystemNewDrives(OriginalSystem, UpdateDrives, UpdateSystem):-
    filesystem(NameSystem, Usuarios, UsuarioActual, RutaActual,_, Files, Directory, Trash,FechaCreacion,OriginalSystem),
    filesystem(NameSystem, Usuarios, UsuarioActual, RutaActual,UpdateDrives, Files, Directory, Trash,FechaCreacion,UpdateSystem).

setListUsers(NewUser, OriginalUsers, UpdateUsers):-
    append(OriginalUsers, [NewUser], UpdateUsers).

setSystemNewUsers(OriginalSystem, UpdateUsers, UpdateSystem):-
    filesystem(NameSystem,_, UsuarioActual, RutaActual,Drives, Files, Directory, Trash,FechaCreacion,OriginalSystem),
    filesystem(NameSystem, UpdateUsers, UsuarioActual, RutaActual,Drives, Files, Directory, Trash,FechaCreacion, UpdateSystem).

setUserActual(NewUser, OriginalUser, UpdateUser):-
    append(OriginalUser, [NewUser], UpdateUser).

setSystemNewLogin(OriginalSystem, UpdateUser,UpdateSystem):-
    filesystem(NameSystem,Usuarios, _, RutaActual,Drives, Files, Directory, Trash,FechaCreacion,OriginalSystem),
    filesystem(NameSystem, Usuarios, UpdateUser, RutaActual,Drives, Files, Directory, Trash,FechaCreacion, UpdateSystem).

setSystemLogout(OriginalSystem,UpdateSystem):-
    filesystem(NameSystem,Usuarios, _, RutaActual,Drives, Files, Directory, Trash,FechaCreacion,OriginalSystem),
    filesystem(NameSystem, Usuarios,[], RutaActual,Drives, Files, Directory, Trash,FechaCreacion, UpdateSystem).


setSystemDriveActual(OriginalSystem, LetterDrive,UpdateSystem):-
    filesystem(NameSystem,Usuarios, UsuarioActual,_,Drives, Files, Directory, Trash,FechaCreacion,OriginalSystem),
    filesystem(NameSystem, Usuarios,UsuarioActual,LetterDrive,Drives, Files, Directory, Trash,FechaCreacion, UpdateSystem).


setNewDirectory(NewDirectory, OriginalDirectory, UpdateDirectories):-
    append(OriginalDirectory, [NewDirectory], UpdateDirectories).

setSystemDirectories(OriginalSystem, UpdateDirectories,UpdateSystem):-
    filesystem(NameSystem,Usuarios, UsuarioActual,RutaActual,Drives, Files,_, Trash,FechaCreacion,OriginalSystem),
    filesystem(NameSystem, Usuarios,UsuarioActual,RutaActual,Drives, Files, UpdateDirectories, Trash,FechaCreacion,UpdateSystem).

setNewFile(NewFile,OriginalFile,UpdateFile):-
    append(OriginalFile,[NewFile],UpdateFile).

setSystemFiles(OriginalSystem, UpdateFile,UpdateSystem):-
    filesystem(NameSystem,Usuarios, UsuarioActual,RutaActual,Drives, _,Directory, Trash,FechaCreacion,OriginalSystem),
    filesystem(NameSystem, Usuarios,UsuarioActual,RutaActual,Drives, UpdateFile, Directory, Trash,FechaCreacion, UpdateSystem).

setNewTrash(NewTrash,OriginalTrash,UpdateTrash):-
    append(OriginalTrash,[NewTrash],UpdateTrash).

setSystemTrash(OriginalSystem,UpdateTrash,UpdateSystem):-
    filesystem(NameSystem,Usuarios, UsuarioActual,RutaActual,Drives, Files,Directory, _,FechaCreacion,OriginalSystem),
    filesystem(NameSystem, Usuarios,UsuarioActual,RutaActual,Drives, Files, Directory, UpdateTrash,FechaCreacion, UpdateSystem).

    

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

es_login_vacio([]).

list_simbolos_CD(SimbolPath):-
    \+ member(SimbolPath,["..","/", ".","./","../dir","././././"]).

list_simbolos_mismaCarpeta(SimbolPath):-
    member(SimbolPath,[".","./","../dir","././././"]).

slash_presente(String):-
    atom_chars(String, ListaCaracteres),
    member(/, ListaCaracteres).

cortar_string_slash(Input, String) :-
    sub_atom(Input, _, _, After, '/'),
    sub_atom(Input, _, After, 0, Atom),
    atom_string(Atom,String).

ubicacionDirectory(N, [[N,_,_,_,_,Ubicacion] | _], Ubicacion).
ubicacionDirectory(N, [ _ | OtrosDirectory], Ubicacion) :-
    ubicacionDirectory(N, OtrosDirectory, Ubicacion).

%F01: TDA system - constructor.
%Descripcion: Predicado contruye un nuevo sistema.
%Dominio: NameSystem(str) X System(str)
%Meta Primaria: system/2
%Meta Secundaria: filesystemFecha/10
%				: filesystem/10
system(NameSystem, System):-
    filesystemFecha(_,_,_,_,_,_,_,_,Fecha,_),
    filesystem(NameSystem, [],[],[],[],[],[],[],Fecha, System).
   
%F02: TDA system - addDrive.
%Descripcion: Predicado añade una nueva unidad al sistema.
%Dominio: OriginalSystem(list) X LetterDrive (str) X NameDrive (str) X Capacity (int) X UpdateSystem(list)
%Meta Primaria: systemAddDrive/5
%Meta Secundaria: drive/4
%				: getDrives/2
%				: listaLetter/2
%				: \+member/2
%				: setaddDrives/3
%				: setaddDrives/3
systemAddDrive(OriginalSystem, LetterDrive, NameDrive, Capacity,UpdateSystem):-
    drive(LetterDrive,NameDrive,Capacity,NewDrive),
    getDrives(OriginalSystem, DrivesActuales),
    listaLetter(DrivesActuales,LetterActuales),
    \+member(LetterDrive,LetterActuales),
    setaddDrives(NewDrive, DrivesActuales, UpdateDrives),
    setSystemNewDrives(OriginalSystem, UpdateDrives, UpdateSystem).

%F03: TDA system - register.
%Descripcion: Predicado añade un nuevo usuario al sistema.
%Dominio: OriginalSystem(list) X NewUser (str) X UpdateSystem(list)
%Meta Primaria: systemRegister/3
%Meta Secundaria: getListUsers/2
%				: \+member/2
%				: setListUsers/3
%				: setSystemNewUsers/3
systemRegister(OriginalSystem, NewUser,UpdateSystem):-
    getListUsers(OriginalSystem, OriginalUsers),
    \+member(NewUser,OriginalUsers),
    setListUsers(NewUser, OriginalUsers, UpdateUsers),
    setSystemNewUsers(OriginalSystem, UpdateUsers, UpdateSystem).

%F04: TDA system - login.
%Descripcion: Predicado inicia sesion con un usuario en el sistema.
%Dominio: OriginalSystem(list) X UserLog(str) X UpdateSystem(list)
%Meta Primaria: systemLogin/3
%Meta Secundaria: getListUsers/2
%				: existe/2
%				: getUserActual/2
%				: es_login_vacio/1
%				: setUserActual/3
%				: setSystemNewLogin/3
systemLogin(OriginalSystem,UserLog,UpdateSystem):-
    getListUsers(OriginalSystem, OriginalListUsers),
    existe(UserLog,OriginalListUsers),
    getUserActual(OriginalSystem, OriginalUser),
    es_login_vacio(OriginalUser),
    setUserActual(UserLog, OriginalUser, UpdateUser),
    setSystemNewLogin(OriginalSystem,UpdateUser,UpdateSystem).

%F05:TDA system - logout.
%Descripcion: Predicado cierra la sesion de un usuario en el sistema.
%Dominio: OriginalSystem(list) X UpdateSystem(list)
%Meta Primaria: systemLogout/2
%Meta Secundaria: getUserActual/2
%				: \+ es_login_vacio/1
%				: setSystemLogout/2
systemLogout(OriginalSystem,UpdateSystem):-
    getUserActual(OriginalSystem, UserActual),
    \+ es_login_vacio(UserActual),
    setSystemLogout(OriginalSystem,UpdateSystem).

%F06:TDA system - switch-drive.
%Descripcion: Predicado fija la unidad en ña que usuario realizará acciones.
%Dominio: OriginalSystem(list) X LetterDrive(str) X UpdateSystem(list)
%Meta Primaria: systemSwitchDrive/3
%Meta Secundaria: getDrives/2
%				: listaLetter/2
%				: member/2
%				: getUserActual/2
%				: \+ es_login_vacio/1
%				: setSystemDriveActual/3
systemSwitchDrive(OriginalSystem, LetterDrive,UpdateSystem):-
    getDrives(OriginalSystem, DrivesActuales),
    listaLetter(DrivesActuales,LetterActuales),
    member(LetterDrive,LetterActuales),
    getUserActual(OriginalSystem, UserActual),
    \+ es_login_vacio(UserActual),
    setSystemDriveActual(OriginalSystem, [LetterDrive],UpdateSystem).

%F07: TDA system - mkdir (make directory).
%Descripcion: Predicado crea directorios dentro de una unidad.
%Dominio: OriginalSystem(list) X NameNewDirectory(str) X UpdateSystem(list)
%Meta Primaria: systemMkdir/3
%Meta Secundaria: getUserActual/2
%				: getRutaActual/2
%				: getFecha/1
%				: directory/7
%				: getDirectory/2
%				: setNewDirectory/3
%				: setSystemDirectories/3
systemMkdir(OriginalSystem,NameNewDirectory,UpdateSystem):-
    getUserActual(OriginalSystem, UserActual),
    getRutaActual(OriginalSystem, RutaActual),
    getFecha(Fecha),
    directory(NameNewDirectory,UserActual, Fecha, Fecha,[],RutaActual, NewDirectory),
    getDirectory(OriginalSystem, DirectoryActuales),
    setNewDirectory(NewDirectory, DirectoryActuales,UpdateDirectories),
    setSystemDirectories(OriginalSystem,UpdateDirectories,UpdateSystem).

%F08: TDA system- cd (change directory).

%Descripcion: Predicado cambia la ruta Actual, en este caso se recibe el simbolo ".." que mueve la ruta a la carpeta de nivel anterior.
%Dominio: OriginalSystem(list) X NameDirectory(str) X UpdateSystem(list).
%Meta Primaria: systemCd/3
%Meta Secundaria: NameDirectory/1
%				: getRutaActual/2
%				: eliminarUltimaUbicacion/2
%				: setSystemDriveActual/3
systemCd(OriginalSystem,NameDirectory, UpdateSystem):-
    NameDirectory == "..",
    getRutaActual(OriginalSystem, RutaActual),
    eliminarUltimaUbicacion(RutaActual,NewRuta),
    setSystemDriveActual(OriginalSystem, NewRuta,UpdateSystem).

%Descripcion: Predicado cambia la ruta Actual, en este caso se recibe el simbolo "/" que cambia la ruta a la raiz de la unidad.
%Dominio: OriginalSystem(list) X NameDirectory(str) X UpdateSystem(list).
%Meta Primaria: systemCd/3
%Meta Secundaria: NameDirectory/1
%				: getRutaActual/2
%				: seleccionarPrimeraUbicacion/2
%				: setSystemDriveActual/3
systemCd(OriginalSystem, NameDirectory, UpdateSystem):-
    NameDirectory == "/",
    getRutaActual(OriginalSystem, RutaActual),
    seleccionarPrimeraUbicacion(RutaActual,NewRuta),
    setSystemDriveActual(OriginalSystem,NewRuta,UpdateSystem).

%Descripcion: Predicado cambia la ruta Actual a la indicada en el nombre del directorio ingresado.
%Dominio: OriginalSystem(list) X NameDirectory(str) X UpdateSystem(list).
%Meta Primaria: systemCd/3
%Meta Secundaria: list_simbolos_CD/1
%				: \+ slash_presente/1
%				: getDirectory/2
%				: ubicacionDirectory/3
%				: append/3
%				: setSystemDriveActual/3
systemCd(OriginalSystem, NameDirectory, UpdateSystem):-
    list_simbolos_CD(NameDirectory),
    \+ slash_presente(NameDirectory),
    getDirectory(OriginalSystem, DirectoryActuales),
    ubicacionDirectory(NameDirectory,DirectoryActuales,Ubicacion),
    append(Ubicacion, [NameDirectory], RutaNew),
    setSystemDriveActual(OriginalSystem,RutaNew,UpdateSystem).

%Descripcion: Predicado cambia la ruta Actual a la indicada en el nombre del directorio ingresado (directorio presenta simbolos /).
%Dominio: OriginalSystem(list) X NameDirectory(str) X UpdateSystem(list).
%Meta Primaria: systemCd/3
%Meta Secundaria: list_simbolos_CD/1
%				: slash_presente/1
%				: cortar_string_slash/2
%				: getDirectory/2
%				: ubicacionDirectory/3
%				: append/3
%				: setSystemDriveActual/3
systemCd(OriginalSystem, NameDirectory, UpdateSystem):-
    list_simbolos_CD(NameDirectory),
   	slash_presente(NameDirectory),
    cortar_string_slash(NameDirectory, NewNameDirectory),
    getDirectory(OriginalSystem, DirectoryActuales),
    ubicacionDirectory(NewNameDirectory,DirectoryActuales,Ubicacion),
    append(Ubicacion, [NewNameDirectory], RutaNew),
    setSystemDriveActual(OriginalSystem,RutaNew,UpdateSystem).

%Descripcion: Predicado reconoce simbolo y mantiene la misma ruta del filesystem anterior.
%Dominio: OriginalSystem(list) X NameDirectory(str) X UpdateSystem(list).
%Meta Primaria: systemCd/3
%Meta Secundaria: list_simbolos_mismaCarpeta/1
%				: filesystem/10
%				: filesystem/10
systemCd(OriginalSystem, NameDirectory, UpdateSystem):-
    list_simbolos_mismaCarpeta(NameDirectory),
    filesystem(Nombre, Usuarios, UsuarioActual, RutActual, Drives, Files, Directory, Trash, Fecha,OriginalSystem),
	filesystem(Nombre, Usuarios, UsuarioActual, RutActual, Drives, Files, Directory, Trash, Fecha,UpdateSystem).

