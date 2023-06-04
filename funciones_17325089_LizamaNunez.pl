%TDA 
%REPRESENTACIÓN

%Filesystem= Nombre(str) X Usuarios(list) X UsuarioLog(list) X RutaActual(List) X Drives(list) X Files(list) X Directory(list) X Trash(list) X FechadeCreacion (number) X NameSystemUpdate(str)
%Drives= Letter(str) X NameDrive(str) X Capacity(number) X NameUpdateDrive(str)
%Files = NameExtension(str) X Content(str) X NameFile(str)
%Directory= NameDirectory(str) X UsuarioCreador(list) X FechaCreacion(list) X FechaModificacion(list) X Atributos(list) X Ubicacion(list) X NameUpdateDirectory(list)
%Trash = Trash(list)

%CAPA CONSTRUCTORA

%Constructor Filesystem Con Fecha.
%Descripcion: Predicado crea un filesystem agregando la fecha de creación.
%Dominio: Nombre(str), Usuarios(list), UsuarioActual(list), RutaActual(List), Drives(list), Files(list), Directory(list), Trash(list),FechadeCreacion(number), NameSystemUpdate(str).
%Meta Primaria: filesystemFecha/10
%Meta Secundaria: get_time/1
filesystemFecha(Nombre, Usuarios, UsuarioActual, RutActual, Drives, Files, Directory, Trash,Fecha,[Nombre, Usuarios, UsuarioActual, RutActual, Drives, Files, Directory, Trash, Fecha]):-
    get_time(Fecha).

%Descripcion: Predicado crea un filesystem, se utiliza para copiar información desde filesystem anterior y no tener problemas al momento de cargar la fecha.
%Dominio: Nombre(str), Usuarios(list), UsuarioActual(list), RutaActual(List), Drives(list), Files(list), Directory(list), Trash(list), FechadeCreacion(number), NameSystemUpdate(str).
%Meta Primaria: filesystemFecha/10
filesystem(Nombre, Usuarios, UsuarioActual, RutActual, Drives, Files, Directory, Trash, Fecha,[Nombre, Usuarios, UsuarioActual, RutActual, Drives, Files, Directory, Trash, Fecha]).


%Constructor Drive
%Descripcion: Predicado crea un drive. 
%Dominio: Letter(str), NameDrive(str), Capacity(number), UpdateDrive(str).
%Meta Primaria: drive/4
drive(Letter, NameDrive, Capacity,[Letter, NameDrive, Capacity]).

%Constructor Directory
%Descripcion: Predicado crea un directory. 
%Dominio: NameDirectory(str), CreatorUser(list), FechaCreacion(number), FechaModificacion(number),Atributos(list),Ubicacion(list),UpdateDirectory(str).
%Meta Primaria: directory/7
directory(NameDirectory, CreatorUser, FechaCreacion, FechaModificacion, Atributos, Ubicacion,[NameDirectory, CreatorUser, FechaCreacion, FechaModificacion, Atributos, Ubicacion]).

%Constructor file
%Descripcion: Predicado crea un file. 
%Dominio: NameFile(str), Contenido(list),UpdateFile(str).
%Meta Primaria: file/3
file(NameFile, Contenido,[NameFile, Contenido]).

%%%%
newFile(NameFile, Contenido, Ruta,[NameFile, Contenido, Ruta]).


%CAPA SELECTORA

%Descripcion: Predicado obtiene nombre del sistema.
%Dominio: SistemaActual(str), NombreSistema(str).
%Meta Primaria: getNameSystem/2
%Meta Secundaria: filesystem/10
getNameSystem(SistemaActual, NombreSistema):-
    filesystem(NombreSistema,_,_,_,_,_,_,_,_,SistemaActual).

%Descripcion: Predicado obtiene la lista de usuarios del sistema.
%Dominio: SistemaActual(str), ListUsers(list).
%Meta Primaria: getListUsers/2
%Meta Secundaria: filesystem/10
getListUsers(SistemaActual, ListUsers):-
    filesystem(_,ListUsers,_,_,_,_,_,_,_,SistemaActual).

%Descripcion: Predicado obtiene el usuario actual del sistema.
%Dominio: SistemaActual(str), UserActual(list).
%Meta Primaria: getUserActual/2
%Meta Secundaria: filesystem/10
getUserActual(SistemaActual, UserActual):-
    filesystem(_,_,UserActual,_,_,_,_,_,_,SistemaActual).

%Descripcion: Predicado obtiene la ruta actual del sistema.
%Dominio: SistemaActual(str), RutaActual(list).
%Meta Primaria: getRutaActual/2
%Meta Secundaria: filesystem/10
getRutaActual(SistemaActual, RutaActual):-
    filesystem(_,_,_,RutaActual,_,_,_,_,_,SistemaActual).

%Descripcion: Predicado obtiene el listado de drives actual del sistema.
%Dominio: SistemaActual(str), DrivesActuales(list).
%Meta Primaria: getDrives/2
%Meta Secundaria: filesystem/10
getDrives(SistemaActual, DrivesActuales):-
    filesystem(_,_,_,_,DrivesActuales,_,_,_,_,SistemaActual).

%Descripcion: Predicado obtiene letter del drive seleccionado.
%Dominio: Drive(list), Letter(str).
%Meta Primaria: getLetterDrive/2
%Meta Secundaria: drive/4
getLetterDrive(Drive, Letter):-
    drive(Letter,_,_,Drive).

%Descripcion: Predicado obtiene listado de files del sistema actual.
%Dominio: SistemaActual(str), FilesActuales(list).
%Meta Primaria: getFiles/2
%Meta Secundaria: filesystem/10
getFiles(SistemaActual, FilesActuales):-
    filesystem(_,_,_,_,_,FilesActuales,_,_,_,SistemaActual).

%Descripcion: Predicado obtiene fecha actual en formato Unix.
%Dominio: Fecha(str).
%Meta Primaria: getFecha/1
%Meta Secundaria: get_time/1
getFecha(Fecha):-
    get_time(Fecha).


%%%
getDatosDirectory(NameFile, [[NameFile, CreatorUser, FechaCreacion, FechaModificacion, Atributos,_] | _],CreatorUser,FechaCreacion,FechaModificacion,Atributos).
getDatosDirectory(NameFile, [ _ | Tail], CreatorUser, FechaCreacion, FechaModificacion, Atributos):-
    getDatosDirectory(NameFile, Tail, CreatorUser, FechaCreacion, FechaModificacion, Atributos).


getRutaDirectory(NameDirectory, [[NameDirectory,_,_,_,_,RutaDirectory] | _], RutaDirectory).
getRutaDirectory(NameDirectory, [ _ | Tail], RutaDirectory) :-
    getRutaDirectory(NameDirectory, Tail, RutaDirectory).

%Descripcion: Predicado obtener contenido desde file a partir de la busqueda(iteración) del nombre del file.
%Dominio: NameFile(str), ListFiles(list), Contenido(str).
%Meta Primaria: getContenidoFile/3
getContenidoFile(NameFile, [[NameFile,Contenido,_] | _],Contenido).
%Descripcion: Predicado obtener contenido desde file a partir de la busqueda(iteración) del nombre del file.
%Dominio: NameFile(str), ListFiles(list), Contenido(str).
%Meta Primaria: getContenidoFile/3
%Meta Secundaria: getContenidoFile/3
getContenidoFile(NameFile, [ _ | Tail], Contenido) :-
    getContenidoFile(NameFile, Tail, Contenido).

%%%
getRutaFile(NameFile, [[NameFile,_,Ruta] | _],Ruta).
getRutaFile(NameFile, [ _ | Tail], Ruta) :-
    getRutaFile(NameFile, Tail, Ruta).

%%%
getCapacityDrive(LetterDrive, [[LetterDrive,_,Capacity] | _],Capacity).
getCapacityDrive(LetterDrive, [ _ | Tail], Capacity) :-
    getCapacityDrive(LetterDrive, Tail, Capacity).


substring_contenido(Sub, Str) :-
    sub_atom(Str, _, _, _, Sub).


eliminarFileConSubstring(_,[], []).
eliminarFileConSubstring(Sub, [[String,_,_]|Rest], Result) :-
    substring_contenido(Sub,String), !,
    eliminarFileConSubstring(Sub, Rest, Result).
eliminarFileConSubstring(Sub, [List|Rest], [List|UpdatedRest]) :-
    eliminarFileConSubstring(Sub, Rest, UpdatedRest).

buscarFileConSubstring(_,[], []).
buscarFileConSubstring(Sub, [[String,_,_]|Rest], Result) :-
    \+ substring_contenido(Sub,String), !,
    buscarFileConSubstring(Sub, Rest, Result).
buscarFileConSubstring(Sub, [List|Rest], [List|UpdatedRest]) :-
    buscarFileConSubstring(Sub, Rest, UpdatedRest).


listFileConUbicacion(_,[], []).
listFileConUbicacion(Ubicacion, [[_,_,Ruta]|Rest],Result) :-
    \+ existe(Ubicacion,Ruta), !,
    listFileConUbicacion(Ubicacion, Rest, Result).
listFileConUbicacion(Ubicacion, [List|Rest], [List|UpdatedRest]) :-
    listFileConUbicacion(Ubicacion, Rest, UpdatedRest).

listFileSinUbicacion(_,[], []).
listFileSinUbicacion(Ubicacion, [[_,_,Ruta]|Rest],Result) :-
    existe(Ubicacion,Ruta), !,
    listFileSinUbicacion(Ubicacion, Rest, Result).
listFileSinUbicacion(Ubicacion, [List|Rest], [List|UpdatedRest]) :-
    listFileSinUbicacion(Ubicacion, Rest, UpdatedRest).

listDirectoryConUbicacion(_,[], []).
listDirectoryConUbicacion(Ubicacion, [[_,_,_,_,_,Ruta]|Rest],Result) :-
    \+ existe(Ubicacion,Ruta), !,
    listDirectoryConUbicacion(Ubicacion, Rest, Result).
listDirectoryConUbicacion(Ubicacion, [List|Rest], [List|UpdatedRest]) :-
    listDirectoryConUbicacion(Ubicacion, Rest, UpdatedRest).

listDirectorySinUbicacion(_,[], []).
listDirectorySinUbicacion(Ubicacion, [[_,_,_,_,_,Ruta]|Rest],Result) :-
    existe(Ubicacion,Ruta), !,
    listDirectorySinUbicacion(Ubicacion, Rest, Result).
listDirectorySinUbicacion(Ubicacion, [List|Rest], [List|UpdatedRest]) :-
    listDirectorySinUbicacion(Ubicacion, Rest, UpdatedRest).




%Descripcion: Predicado obtiene el listado de directorios en el sistema actual.
%Dominio: SistemaActual(str), DirectoryActuales(list).
%Meta Primaria: getDirectory/2
%Meta Secundaria: filesystem/10
getDirectory(SistemaActual, DirectoryActuales):-
    filesystem(_,_,_,_,_,_,DirectoryActuales,_,_,SistemaActual).

%Descripcion: Predicado obtiene el listado de documentos en la papelera en el sistema actual.
%Dominio: SistemaActual(str), TrashActual(list).
%Meta Primaria: getTrash/2
%Meta Secundaria: filesystem/10
getTrash(SistemaActual, TrashActual):-
    filesystem(_,_,_,_,_,_,_,TrashActual,_,SistemaActual).


%CAPA MODIFICADORA

%Descripcion: Predicado agrega drives a un listado de drives.
%Dominio: NewDrive(list), OriginalDrives(list), UpdateDrives(list).
%Meta Primaria: setaddDrives/3
%Meta Secundaria: append/3
setaddDrives(NewDrive, OriginalDrives, UpdateDrives):-
    append(OriginalDrives,[NewDrive], UpdateDrives).

%Descripcion: Predicado actualiza nuevo listado de drives en sistema.
%Dominio: OriginalSystem(str), UpdateDrives(list), UpdateSystem(str).
%Meta Primaria: setSystemNewDrives/3
%Meta Secundaria: filesystem/10
%				: filesystem/10
setSystemNewDrives(OriginalSystem, UpdateDrives, UpdateSystem):-
    filesystem(NameSystem, Usuarios, UsuarioActual, RutaActual,_, Files, Directory, Trash,FechaCreacion,OriginalSystem),
    filesystem(NameSystem, Usuarios, UsuarioActual, RutaActual,UpdateDrives, Files, Directory, Trash,FechaCreacion,UpdateSystem).

%Descripcion: Predicado agrega un usuario a un listado de usuarios en el sistema actual.
%Dominio: NewUser(str), OriginalUsers(list), UpdateUsers(list).
%Meta Primaria: setListUsers/3
%Meta Secundaria: append/3
setListUsers(NewUser, OriginalUsers, UpdateUsers):-
    append(OriginalUsers, [NewUser], UpdateUsers).

%Descripcion: Predicado actualiza el listado de usuario en el sistema actual.
%Dominio: OriginalSystem(str), UpdateUsers(list), UpdateSystem(str).
%Meta Primaria: setSystemNewUsers/3
%Meta Secundaria: filesystem/10
%				: filesystem/10
setSystemNewUsers(OriginalSystem, UpdateUsers, UpdateSystem):-
    filesystem(NameSystem,_, UsuarioActual, RutaActual,Drives, Files, Directory, Trash,FechaCreacion,OriginalSystem),
    filesystem(NameSystem, UpdateUsers, UsuarioActual, RutaActual,Drives, Files, Directory, Trash,FechaCreacion, UpdateSystem).

%Descripcion: Predicado agrega un usuario al listado de usuario logueado.
%Dominio: NewUser(str), OriginalUsers(list), UpdateUsers(list).
%Meta Primaria: setUserActual/3
%Meta Secundaria: append/3
setUserActual(NewUser, OriginalUser, UpdateUser):-
    append(OriginalUser, [NewUser], UpdateUser).

%Descripcion: Predicado actualiza el usuario logueado en el sistema actual.
%Dominio: OriginalSystem(str), UpdateUser(str), UpdateSystem(str).
%Meta Primaria: setSystemNewLogin/3
%Meta Secundaria: filesystem/10
%				: filesystem/10
setSystemNewLogin(OriginalSystem, UpdateUser,UpdateSystem):-
    filesystem(NameSystem,Usuarios, _, RutaActual,Drives, Files, Directory, Trash,FechaCreacion,OriginalSystem),
    filesystem(NameSystem, Usuarios, UpdateUser, RutaActual,Drives, Files, Directory, Trash,FechaCreacion, UpdateSystem).

%Descripcion: Predicado desloguea usuario del sistema dejando list vacio.
%Dominio: OriginalSystem(str), UpdateSystem(str).
%Meta Primaria: setSystemLogout/2
%Meta Secundaria: filesystem/10
%				: filesystem/10
setSystemLogout(OriginalSystem,UpdateSystem):-
    filesystem(NameSystem,Usuarios, _, RutaActual,Drives, Files, Directory, Trash,FechaCreacion,OriginalSystem),
    filesystem(NameSystem, Usuarios,[], RutaActual,Drives, Files, Directory, Trash,FechaCreacion, UpdateSystem).


%Descripcion: Predicado actualiza la ubicacion actual del sistema.
%Dominio: OriginalSystem(str),LetterDrive(str), UpdateSystem(str).
%Meta Primaria: setSystemDriveActual/3
%Meta Secundaria: filesystem/10
%				: filesystem/10
setSystemDriveActual(OriginalSystem, LetterDrive,UpdateSystem):-
    filesystem(NameSystem,Usuarios, UsuarioActual,_,Drives, Files, Directory, Trash,FechaCreacion,OriginalSystem),
    filesystem(NameSystem, Usuarios,UsuarioActual,LetterDrive,Drives, Files, Directory, Trash,FechaCreacion, UpdateSystem).

%Descripcion: Predicado agrega un directorio a un listado de directorios del sistema.
%Dominio: NewDirectory(list), OriginalDirectory(list), UpdateDirectories(list).
%Meta Primaria: setNewDirectory/3
%Meta Secundaria: append/3
setNewDirectory(NewDirectory, OriginalDirectory, UpdateDirectories):-
    append(OriginalDirectory,[NewDirectory], UpdateDirectories).

%Descripcion: Predicado actualiza el listado de directories en el sistema.
%Dominio: OriginalSystem(str),UpdateDirectories(list), UpdateSystem(str).
%Meta Primaria: setSystemDirectories/3
%Meta Secundaria: filesystem/10
%				: filesystem/10
setSystemDirectories(OriginalSystem,UpdateDirectories,UpdateSystem):-
    filesystem(NameSystem,Usuarios, UsuarioActual,RutaActual,Drives, Files,_, Trash,FechaCreacion,OriginalSystem),
    filesystem(NameSystem, Usuarios,UsuarioActual,RutaActual,Drives, Files,UpdateDirectories, Trash,FechaCreacion,UpdateSystem).

%Descripcion: Predicado agrega un nuevo file a un listado de files del sistema.
%Dominio: NewFile(list), OriginalFile(list), UpdateFile(list).
%Meta Primaria: setNewFile/3
%Meta Secundaria: append/3
setNewFile(NewFile,OriginalFile,UpdateFile):-
    append(OriginalFile,[NewFile],UpdateFile).

setNewListFile(NewFile,OriginalFile,UpdateFile):-
    append(OriginalFile,NewFile,UpdateFile).

%%
setOriginalFile(OriginalSystem,NewFile,RealNewFile):-
    getRutaActual(OriginalSystem, RutaActual),
    file(NameReal,ContentReal,NewFile),
    newFile(NameReal, ContentReal, RutaActual, RealNewFile).
%Descripcion: Predicado actualiza el listado de files en el sistema.
%Dominio: OriginalSystem(str),UpdateFile(list), UpdateSystem(str).
%Meta Primaria: setSystemFiles/3
%Meta Secundaria: filesystem/10
%				: filesystem/10
setSystemFiles(OriginalSystem, UpdateFile,UpdateSystem):-
    filesystem(NameSystem,Usuarios, UsuarioActual,RutaActual,Drives, _,Directory, Trash,FechaCreacion,OriginalSystem),
    filesystem(NameSystem, Usuarios,UsuarioActual,RutaActual,Drives, UpdateFile, Directory, Trash,FechaCreacion, UpdateSystem).

%Descripcion: Predicado agrega un documento a un listado de trash del sistema.
%Dominio: NewTrash(list), OriginalTrash(list), UpdateTrash(list).
%Meta Primaria: setNewTrash/3
%Meta Secundaria: append/3
setNewTrash(NewTrash,OriginalTrash,UpdateTrash):-
    append(OriginalTrash,[NewTrash],UpdateTrash).

setUnirTrash(NewTrash,OriginalTrash,UpdateTrash):-
    append(OriginalTrash,NewTrash,UpdateTrash).

%Descripcion: Predicado actualiza el listado de trash en el sistema.
%Dominio: OriginalSystem(str),UpdateTrash(list), UpdateSystem(str).
%Meta Primaria: setSystemTrash/3
%Meta Secundaria: filesystem/10
%				: filesystem/10
setSystemTrash(OriginalSystem,UpdateTrash,UpdateSystem):-
    filesystem(NameSystem,Usuarios, UsuarioActual,RutaActual,Drives, Files,Directory, _,FechaCreacion,OriginalSystem),
    filesystem(NameSystem, Usuarios,UsuarioActual,RutaActual,Drives, Files, Directory, UpdateTrash,FechaCreacion, UpdateSystem).

    

%OTRAS CAPAS

%Descripcion: Predicado itera listado de elementos hasta encontrar el buscado, devuelve un True o False.
%Dominio: Elemento(str),ListaElementos(list).
%Meta Primaria: existe/2
existe(Elemento, [Elemento|_]):- !.
%Descripcion: Predicado itera listado de elementos hasta encontrar el buscado, devuelve un True o False.
%Dominio: Elemento(str),ListaElementos(list).
%Meta Primaria: existe/2
%Meta Secundaria: existe/2
existe(Elemento, [_|Resto]):-
    existe(Elemento, Resto).


%Descripcion: Predicado itera listado de elementos y elemina el ultimo elemento de la lista.
%Dominio: ListaElementosOriginal(list),ListaElementosFinal(list).
%Meta Primaria: eliminarUltimaUbicacion/2
eliminarUltimaUbicacion([_| []],[]).
%Descripcion: Predicado itera listado de elementos y elemina el ultimo elemento de la lista.
%Dominio: ListaElementosOriginal(list),ListaElementosFinal(list).
%Meta Primaria: eliminarUltimaUbicacion/2
%Meta Secundaria: eliminarUltimaUbicacion/2
eliminarUltimaUbicacion([Primero | Resto], [Primero | NewLista]):-
    eliminarUltimaUbicacion(Resto,NewLista).

%Descripcion: Predicado itera listado de drives, selecciona los nombre de drives y crea una lista con ellos.
%Dominio: ListaDrives(list),ListaNombreDrives(list).
%Meta Primaria: listaLetter/2
listaLetter([], []).

%Descripcion: Predicado itera listado de drives, selecciona los nombre de drives y crea una lista con ellos.
%Dominio: ListaDrives(list),ListaNombreDrives(list).
%Meta Primaria: listaLetter/2
%Meta Secundaria: listaLetter/2
listaLetter([[Nombre,_,_] | Resto], [Nombre | NuevaLista]) :-
    listaLetter(Resto, NuevaLista).
    
%Descripcion: Predicado selecciona el primer elemento de una lista.
%Dominio: Lista(list),PrimerElemento(list).
%Meta Primaria: seleccionarPrimeraUbicacion/2
seleccionarPrimeraUbicacion([Elemento|_], Elemento).

%Descripcion: Predicado elimina primer elemento de una lista.
%Dominio: Lista(list),RestoLista(list).
%Meta Primaria: eliminarPrimero/2
eliminarPrimero([_|Elemento], Elemento).


ultimo_elemento([X], X). 
ultimo_elemento([_|Resto], Ultimo) :-
    ultimo_elemento(Resto, Ultimo).

%Descripcion: Predicado revisa si lista esta vacia, devuelve true o false.
%Dominio: Lista(list).
%Meta Primaria: es_login_vacio/1.
es_login_vacio([]).

%Descripcion: Predicado identifica si atomo ingresado corresponde a alguno de los elementos en la lista retorna true o false.
%Dominio: SimbolPath(str)
%Meta Primaria: list_simbolos_CD/1
%Meta Secundaria:  \+ member/2
list_simbolos_CD(SimbolPath):-
    \+ member(SimbolPath,["..","/", ".","./","../dir","././././"]).

%Descripcion: Predicado identifica si atomo ingresado corresponde a alguno de los elementos en la lista retorna true o false.
%Dominio: SimbolPath(str)
%Meta Primaria: list_simbolos_mismaCarpeta/1
%Meta Secundaria:  member/2
list_simbolos_mismaCarpeta(SimbolPath):-
    member(SimbolPath,[".","./","../dir","././././"]).

esDirectorioActual(Simbol):-
    member(Simbol,["*.*"]).

%Descripcion: Predicado identifica si atomo presenta el simbolo / dentro de el listado de carecteres, retorna true o false.
%Dominio: String(str)
%Meta Primaria: slash_presente/1
%Meta Secundaria:  atom_chars/2
%				: member/2
slash_presente(String):-
    atom_chars(String, ListaCaracteres),
    member(/, ListaCaracteres).

%%%
punto_presente(String):-
    atom_chars(String, ListaCaracteres),
    member(., ListaCaracteres).

%Descripcion: Predicado identifica si atomo presenta el simbolo / dentro de el listado de carecteres, retorna true o false.
%Dominio: String(str)
%Meta Primaria: slash_presente/1
%Meta Secundaria:  atom_chars/2
%				: member/2
cortar_string_slash(Input, String) :-
    sub_atom(Input, _, _, After, '/'),
    sub_atom(Input, _, After, 0, Atom),
    atom_string(Atom,String).

%Descripcion: Predicado reconocer primer elemento de lista de caracteres como un asterisco, retorna true o false.
%Dominio: String(str)
%Meta Primaria: asteristo_inicial/1
%Meta Secundaria:  atom_chars/2
%				: seleccionarPrimeraUbicacion/2
%				: * == /1
asteristo_inicial(String):-
    atom_chars(String, ListaCaracteres),
    seleccionarPrimeraUbicacion(ListaCaracteres, Simbolo),
    * == Simbolo.

%Descripcion: Predicado elimina asterisco en primer elemento de lista caracteres, devuelve string sin asterisco.
%Dominio: String(str),StringSinAsterisco(str)
%Meta Primaria: quitarAsterico/2
%Meta Secundaria:  atom_chars/2
%				: eliminarPrimero/2
%				: atom_string/2
quitarAsterico(String, StringSinAsterisco):-
    atom_chars(String, ListaCaracteres),
    eliminarPrimero(ListaCaracteres, ListaSinPrimero),
    atom_string(ListaSinPrimero,StringSinAsterisco).
    

%Descripcion: Predicado intera listado de directories en busca de directory con nombre N, retorna ubicacion de directory.
%Dominio: N(str),ListDirectories(list), Ubicacion(str).
%Meta Primaria: ubicacionDirectory/3
ubicacionDirectory(N, [[N,_,_,_,_,Ubicacion] | _], Ubicacion).
%Descripcion: Predicado intera listado de directories en busca de directory con nombre N, retorna ubicacion de directory.
%Dominio: N(str),ListDirectories(list), Ubicacion(str).
%Meta Primaria: ubicacionDirectory/3
%Meta Secundaria:  ubicacionDirectory/3
ubicacionDirectory(N, [ _ | OtrosDirectory], Ubicacion) :-
    ubicacionDirectory(N, OtrosDirectory, Ubicacion).

%Descripcion: Predicado intera listado de files en busca de un nombre de File, elimina dicho file y retorna lista con el resto.
%Dominio: NombreFile(str),ListFiles(list), Resultado(str).
%Meta Primaria: borrarFile/3
borrarFile( NombreFile, [[NombreFile,_,_]|Resto], Resto ). 
%Descripcion: Predicado intera listado de files en busca de un nombre de File, elimina dicho file y retorna lista con el resto.
%Dominio: NombreFile(str),ListFiles(list), Resultado(str).
%Meta Primaria: borrarFile/3
%Meta Secundaria:  NombreFile\= /1
%				: borrarFile/3
borrarFile( NombreFile, [Cabeza|Resto], [Cabeza|Resultado] ) :-
	NombreFile\=Cabeza,
	borrarFile( NombreFile, Resto, Resultado).

%%
%eliminarFileenDrive(LetterDrive, ListFiles, NewListFiles)


borrarDiretory(NameDirectory,[[NameDirectory,_,_,_,_,_]|Resto], Resto ). 
borrarDiretory( NameDirectory, [Cabeza|Resto], [Cabeza|Resultado] ) :-
	NameDirectory\=Cabeza,
	borrarDiretory( NameDirectory, Resto, Resultado).


borrarDrive(LetterDrive,[[LetterDrive,_,_]|Resto], Resto ). 
borrarDrive( LetterDrive, [Cabeza|Resto], [Cabeza|Resultado] ) :-
	LetterDrive\=Cabeza,
	borrarDrive( LetterDrive, Resto, Resultado).


%Descripcion: Predicado identifica trozo de string en un string, retorna true o false.
%Dominio: String(str),TrozoString(str).
%Meta Primaria: reconocer/2
%Meta Secundaria:  sub_atom/5
reconocer(String,TrozoString) :-
    sub_atom(String, _, _, _, TrozoString).


primeraLetra(String, Drive):-
    sub_atom(String,0,1,_,Letra),
    atom_string(Letra,Drive).

%sub_atom(+Atom, ?Before, ?Length, ?After, ?SubAtom)
cortar_ruta_entreslash(Input, String) :-
    sub_atom(Input, 3, _, 1, Atom),
    atom_string(Atom,String).

%%%
%"D:/newFolder/"
crearRuta(Ruta, CambioRuta):-
    primeraLetra(Ruta, Drive),
    cortar_ruta_entreslash(Ruta, Folder),
    CambioRuta = [Drive , Folder].
    
    
cambiarUbicacionFiles(_,[],NuevaLista,NuevaLista).
cambiarUbicacionFiles(NewRuta,[File| Rest],NuevaLista, Final):-
    eliminarUltimaUbicacion(File, NewFile),
    append(NewFile,[NewRuta], FileConNewRuta),
    cambiarUbicacionFiles(NewRuta, Rest, [FileConNewRuta|NuevaLista], Final).
 
%directorioDeBusqueda(NameFileCopy, Directory).
directorioDeBusqueda(NameFileCopy, String) :-
    sub_atom(NameFileCopy, BeforeSymbol, _, _, "/"),
    sub_atom(NameFileCopy, 0, BeforeSymbol, _, Substring),
    atom_string(Substring,String).

substringBusqueda(NameFileCopy,String):-
    sub_atom(NameFileCopy, _,_, AfterSymbol, "/"),
    sub_atom(NameFileCopy, _, AfterSymbol, 0, Substring),
    atom_string(Substring,String).

unir_listas([], Lista, Lista). 
unir_listas([X|Resto1], Lista2, [X|Resultado]) :- 
    unir_listas(Resto1, Lista2, Resultado).


listar(Files, Directory,[Files, Directory]).


longitud_string(Entrada, Longitud) :-
    atom_chars(Entrada, Caracteres),
    length(Caracteres, Longitud).

ubicacionInicio(Before, Inicio):-
    atomic_concat(palabra_inicia_posicion_ , Before, Atomo),
    atom_string(Atomo,Inicio).
    
    
%F01: TDA system - constructor.
%Descripcion: Predicado contruye un nuevo sistema.
%Dominio: NameSystem(str) X System(str)
%Meta Primaria: system/2
%Meta Secundaria: filesystemFecha/10
%				: filesystem/10
system(NameSystem, System):-
    filesystemFecha(_,_,_,_,_,_,_,_,Fecha,_),
    filesystem(NameSystem,[],[],[],[],[],[],[],Fecha, System).
   
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
    directory(NameNewDirectory, UserActual, Fecha, Fecha,[], RutaActual, NewDirectory),
    getDirectory(OriginalSystem, DirectoryActuales),
    setNewDirectory(NewDirectory,DirectoryActuales,UpdateDirectories),
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


%F09: TDA system- add-file.
%Descripcion: Predicado añade un archivo a la ruta actual.
%Dominio: OriginalSystem(list) X NewFile(str) X UpdateSystem(list).
%Meta Primaria: systemAddFile/3
%Meta Secundaria: getFiles/2
%				: setNewFile/3
%				: setSystemFiles/3
systemAddFile(OriginalSystem, NewFile,UpdateSystem):-
    setOriginalFile(OriginalSystem,NewFile,RealNewFile),
    getFiles(OriginalSystem, OriginalFile),
    setNewFile(RealNewFile,OriginalFile,UpdateFile),
    setSystemFiles(OriginalSystem, UpdateFile,UpdateSystem).

%F10: TDA system- del.
%file (1/5).
systemDel(OriginalSystem,NameFileDeleted,UpdateSystem):-
    \+ asteristo_inicial(NameFileDeleted),
    getFiles(OriginalSystem, ListFiles),
   	getContenidoFile(NameFileDeleted,ListFiles,ContentFileDeleted),
    getRutaFile(NameFileDeleted,ListFiles,RutaFileDeleted),
    newFile(NameFileDeleted, ContentFileDeleted,RutaFileDeleted,FileTrash),
    getTrash(OriginalSystem, OriginalTrash),
    setNewTrash(FileTrash,OriginalTrash,UpdateTrash),
    setSystemTrash(OriginalSystem,UpdateTrash,TemporalSystem),
    getFiles(OriginalSystem, FilesActuales),
    borrarFile(NameFileDeleted,FilesActuales,NewFilesActuales),
    setSystemFiles(TemporalSystem, NewFilesActuales,UpdateSystem).

%"*.txt" --> borra todos los archivos con extension txt.
systemDel(OriginalSystem,NameFileDeleted,UpdateSystem):-
    asteristo_inicial(NameFileDeleted),
    \+ esDirectorioActual(NameFileDeleted),
    quitarAsterico(NameFileDeleted,ExtensionDeleted),
    getFiles(OriginalSystem, ListFiles),
	eliminarFileConSubstring(ExtensionDeleted,ListFiles,NewListFile),
    buscarFileConSubstring(ExtensionDeleted,ListFiles,TrashListFile),
    getTrash(OriginalSystem, OriginalTrash),
    setUnirTrash(TrashListFile,OriginalTrash,UpdateTrash),
    setSystemTrash(OriginalSystem,UpdateTrash,TemporalSystem),
    setSystemFiles(TemporalSystem, NewListFile,UpdateSystem).

%"*.*" borrar todos los archivos del directorio actual.
systemDel(OriginalSystem,NameFileDeleted,UpdateSystem):-
    esDirectorioActual(NameFileDeleted),
    getRutaActual(OriginalSystem, RutaActual),
    ultimo_elemento(RutaActual, UltimaUbicacion),
    getFiles(OriginalSystem, ListFiles),
    listFileConUbicacion(UltimaUbicacion, ListFiles, ListFileTrash),
    listFileSinUbicacion(UltimaUbicacion, ListFiles, NewListFile),
    getTrash(OriginalSystem, OriginalTrash),
    setUnirTrash(ListFileTrash,OriginalTrash,UpdateTrash),
    setSystemTrash(OriginalSystem,UpdateTrash,TemporalSystem),
    setSystemFiles(TemporalSystem, NewListFile,UpdateSystem).
    
   




%"folde1" -> borrar carpeta
systemDel(OriginalSystem,NameFileDeleted,UpdateSystem):-
    \+ punto_presente(NameFileDeleted),
    \+ asteristo_inicial(NameFileDeleted),
    getDirectory(OriginalSystem, DirectoryActuales),
    getDatosDirectory(NameFileDeleted, DirectoryActuales, CreatorUser, FechaCreacion, FechaModificacion,Atributos),
    getRutaDirectory(NameFileDeleted, DirectoryActuales, RutaDirectory),
    directory(NameFileDeleted, CreatorUser, FechaCreacion, FechaModificacion, Atributos, RutaDirectory, DirectoryTrash),
   	getTrash(OriginalSystem, OriginalTrash),
    setNewTrash(DirectoryTrash,OriginalTrash,UpdateTrash),
    setSystemTrash(OriginalSystem,UpdateTrash,TemporalSystem),
    borrarDiretory(NameFileDeleted,DirectoryActuales, NewDirectoryActuales),
    setSystemDirectories(TemporalSystem,NewDirectoryActuales,UpdateSystem).

 
    


%F11: TDA system-Copy
%ARCHIVO
%systemCopy(S,"foo.txt","D:/newFolder/",S1).
systemCopy(OriginalSystem,NameFileCopy,NewRuta,UpdateSystem):-
    \+ slash_presente(NameFileCopy),
    punto_presente(NameFileCopy),
    \+ asteristo_inicial(NameFileCopy),
    getFiles(OriginalSystem, ListFiles),
    getContenidoFile(NameFileCopy,ListFiles,ContentFile),
    crearRuta(NewRuta, CambioRuta),
   	newFile(NameFileCopy, ContentFile,CambioRuta,FileCopy),
    setNewFile(FileCopy,ListFiles,UpdateFile),
    setSystemFiles(OriginalSystem, UpdateFile,UpdateSystem).
%CARPETA
%systemCopy(S,"folder1","D:/newFolder/",S1).
systemCopy(OriginalSystem,NameDirectory,NewRuta,UpdateSystem):-
    \+ slash_presente(NameDirectory),
    \+ punto_presente(NameDirectory),
    \+ asteristo_inicial(NameDirectory),
    getDirectory(OriginalSystem, DirectoryActuales),
    getDatosDirectory(NameDirectory, DirectoryActuales, CreatorUser, FechaCreacion, FechaModificacion,Atributos),
    crearRuta(NewRuta, CambioRuta),
    directory(NameDirectory, CreatorUser, FechaCreacion, FechaModificacion, Atributos, CambioRuta, DirectoryCopy),
    setNewDirectory(DirectoryCopy, DirectoryActuales, UpdateDirectories),
   	setSystemDirectories(OriginalSystem,UpdateDirectories,UpdateSystem).

%Copiar archivos que tengan extension en particula
%systemCopy(S,"*.jpg","D:/newFolder/",S1).
systemCopy(OriginalSystem,NameFileCopy,NewRuta,UpdateSystem):-
    \+ slash_presente(NameFileCopy),
    asteristo_inicial(NameFileCopy),
    quitarAsterico(NameFileCopy,ExtensionCopy),
    getFiles(OriginalSystem, ListFiles),
    %eliminarFileConSubstring(ExtensionCopy,ListFiles,NewListFile). % no cumplen
    buscarFileConSubstring(ExtensionCopy,ListFiles,NewListFile),
    crearRuta(NewRuta, CambioRuta),
    cambiarUbicacionFiles(CambioRuta,NewListFile,[],NuevaLista),
    setNewListFile(NuevaLista,ListFiles,UpdateFile),
    setSystemFiles(OriginalSystem, UpdateFile,UpdateSystem).


%Copiar todas los archivos que comiencen con ...
%systemCopy(S,"folder1/luk_","D:/newFolder/",S1).
systemCopy(OriginalSystem,NameFileCopy,NewRuta,UpdateSystem):-
    slash_presente(NameFileCopy),
    directorioDeBusqueda(NameFileCopy,Directory),
    substringBusqueda(NameFileCopy,Substring),
    getFiles(OriginalSystem, ListFiles),
    listFileConUbicacion(Directory, ListFiles, ListFileinDirectory),
    buscarFileConSubstring(Substring,ListFileinDirectory,NewListFile),
    crearRuta(NewRuta, CambioRuta),
    cambiarUbicacionFiles(CambioRuta,NewListFile,[],NuevaLista),
    setNewListFile(NuevaLista,ListFiles,UpdateFile),
    setSystemFiles(OriginalSystem, UpdateFile,UpdateSystem).

%%F12: TDA system-Move
%Files
systemMove(OriginalSystem,NameFileCopy,NewRuta,UpdateSystem):-
    punto_presente(NameFileCopy),
    getFiles(OriginalSystem, ListFiles),
    getContenidoFile(NameFileCopy,ListFiles,ContentFile),
    crearRuta(NewRuta, CambioRuta),
   	newFile(NameFileCopy, ContentFile,CambioRuta,FileCopy),
    borrarFile(NameFileCopy,ListFiles,NewFilesActuales),
    setNewFile(FileCopy,NewFilesActuales,UpdateFile),
    setSystemFiles(OriginalSystem, UpdateFile,UpdateSystem).
%Directory

systemMove(OriginalSystem,NameDirectoryCopy,NewRuta,UpdateSystem):-
    \+ punto_presente(NameDirectoryCopy),
    getDirectory(OriginalSystem, DirectoryActuales),
    getDatosDirectory(NameDirectoryCopy, DirectoryActuales, CreatorUser, FechaCreacion, FechaModificacion,Atributos),
    crearRuta(NewRuta, CambioRuta),
    directory(NameDirectoryCopy, CreatorUser, FechaCreacion, FechaModificacion, Atributos, CambioRuta, DirectoryCopy),
    borrarDiretory(NameDirectoryCopy,DirectoryActuales,NewDirectoryActuales),
    setNewDirectory(DirectoryCopy, NewDirectoryActuales, UpdateDirectories),
   	setSystemDirectories(OriginalSystem,UpdateDirectories,UpdateSystem).

%F13: TDA system-Ren (rename)
%archivo
systemRen(OriginalSystem, OriginalName, NewName, UpdateSystem):-
    punto_presente(OriginalName),
    getFiles(OriginalSystem, ListFiles),
    getContenidoFile(OriginalName,ListFiles,ContentFile),
    getRutaFile(OriginalName,ListFiles,RutaFile),
   	newFile(NewName, ContentFile,RutaFile,FileNewName),
    borrarFile(OriginalName,ListFiles,NewFilesActuales),
    setNewFile(FileNewName,NewFilesActuales,UpdateFile),
    setSystemFiles(OriginalSystem, UpdateFile,UpdateSystem).

%Directory
systemRen(OriginalSystem, OriginalName, NewName, UpdateSystem):-
    \+ punto_presente(OriginalName),
    getDirectory(OriginalSystem, DirectoryActuales),
    getDatosDirectory(OriginalName, DirectoryActuales, CreatorUser, FechaCreacion, FechaModificacion,Atributos),
    getRutaDirectory(OriginalName, DirectoryActuales, RutaDirectory),
    directory(NewName, CreatorUser, FechaCreacion, FechaModificacion, Atributos, RutaDirectory, DirectoryNewName),
    borrarDiretory(OriginalName,DirectoryActuales,NewDirectoryActuales),
    setNewDirectory(DirectoryNewName, NewDirectoryActuales, UpdateDirectories),
   	setSystemDirectories(OriginalSystem,UpdateDirectories,UpdateSystem).

%F14: TDA system-dir (directory)
%systemDir(S, [ ], Str) -> lista contenido directorio actual.
systemDir(OriginalSystem, Params, Str):-
    es_login_vacio(Params),
    getRutaActual(OriginalSystem, RutaActual),
    ultimo_elemento(RutaActual, UltimaUbicacion),
    getFiles(OriginalSystem, ListFiles),
    listFileConUbicacion(UltimaUbicacion, ListFiles, FilesEnDirectory),
    getDirectory(OriginalSystem, DirectoryActuales),
    listDirectoryConUbicacion(UltimaUbicacion, DirectoryActuales, DirectoryEnUbicacion),
    Files = FilesEnDirectory,
    Directory = DirectoryEnUbicacion,
    listar(Files, Directory, Str).


%systemDir(S, [ ], Str) -> lista contenido directorio actual.

%F15: TDA system-format
%CAMBIA UBICACION ACTUAL
%systemFormat(S,"C", "NewOS",S2)
systemFormat(OriginalSystem, LetterDrive, NewName ,UpdateSystem):-
    getDrives(OriginalSystem, DrivesActuales),
    listaLetter(DrivesActuales,LetterActuales),
    member(LetterDrive,LetterActuales),
    getCapacityDrive(LetterDrive, DrivesActuales, Capacity),
    drive(LetterDrive, NewName, Capacity, NewDrive),
    borrarDrive(LetterDrive, DrivesActuales, NewDrivesActuales),
    setaddDrives(NewDrive, NewDrivesActuales, UpdateDrives),
    setSystemNewDrives(OriginalSystem, UpdateDrives, TemporalSystem),
    getFiles(OriginalSystem, ListFiles),
    listFileSinUbicacion(LetterDrive, ListFiles,NewListFiles),
    getDirectory(OriginalSystem, DirectoryActuales),
    listDirectorySinUbicacion(LetterDrive,DirectoryActuales,NewListDirectory),
    setSystemFiles(TemporalSystem, NewListFiles,TemporalSystemFile),
    setSystemDirectories(TemporalSystemFile,NewListDirectory,TemporalSystemDirectory),
    setSystemDriveActual(TemporalSystemDirectory,[LetterDrive],UpdateSystem).
    
%F18: TDA system-grep --> entrega ocurrencias y ubicacion de la palabra
%systemGrep(S, Search, FileName)
systemGrep(OriginalSystem, Search, FileName):-
    getFiles(OriginalSystem, ListFiles),
    getContenidoFile(FileName,ListFiles,Content),
    sub_atom(Content, Before,_,After,Search),
    longitud_string(Content, Longitud),
    ubicacionInicio(Before, Inicio),
    ubicacionInicio(Before, Inicio),
    
    
    
    
    

    
    
    
    
    


