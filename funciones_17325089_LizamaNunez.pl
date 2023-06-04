
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

%Constructor newfile
%Descripcion: Predicado crea un file que agrega ubicacion.
%Dominio: NameFile(str), Contenido(list), Ruta(list), UpdateFile(str).
%Meta Primaria: newFile/4
newFile(NameFile, Contenido, Ruta,[NameFile, Contenido, Ruta]).






%CAPA SELECTORA


%Descripcion: Predicado obtiene el listado de drives actual del sistema.
%Dominio: SistemaActual(str), DrivesActuales(list).
%Meta Primaria: getDrives/2
%Meta Secundaria: filesystem/10
getDrives(SistemaActual, DrivesActuales):-
    filesystem(_,_,_,_,DrivesActuales,_,_,_,_,SistemaActual).

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

%Descripcion: Predicado obtiene fecha actual en formato Unix.
%Dominio: Fecha(str).
%Meta Primaria: getFecha/1
%Meta Secundaria: get_time/1
getFecha(Fecha):-
    get_time(Fecha).

%Descripcion: Predicado obtiene el listado de directorios en el sistema actual.
%Dominio: SistemaActual(str), DirectoryActuales(list).
%Meta Primaria: getDirectory/2
%Meta Secundaria: filesystem/10
getDirectory(SistemaActual, DirectoryActuales):-
    filesystem(_,_,_,_,_,_,DirectoryActuales,_,_,SistemaActual).

%Descripcion: Predicado obtiene listado de files del sistema actual.
%Dominio: SistemaActual(str), FilesActuales(list).
%Meta Primaria: getFiles/2
%Meta Secundaria: filesystem/10
getFiles(SistemaActual, FilesActuales):-
    filesystem(_,_,_,_,_,FilesActuales,_,_,_,SistemaActual).


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

%Descripcion: Predicado obtener la ruta desde file a partir de la busqueda(iteración) del nombre del file.
%Dominio: NameFile(str), ListFiles(list), Ruta(list).
%Meta Primaria: getRutaFile/3
getRutaFile(NameFile, [[NameFile,_,Ruta] | _],Ruta).
%Descripcion: Predicado obtener la ruta desde file a partir de la busqueda(iteración) del nombre del file.
%Dominio: NameFile(str), ListFiles(list), Ruta(list).
%Meta Primaria: getRutaFile/3
%Meta Secundaria: getRutaFile/3
getRutaFile(NameFile, [ _ | Tail], Ruta) :-
    getRutaFile(NameFile, Tail, Ruta).

%Descripcion: Predicado obtiene el listado de documentos en la papelera en el sistema actual.
%Dominio: SistemaActual(str), TrashActual(list).
%Meta Primaria: getTrash/2
%Meta Secundaria: filesystem/10
getTrash(SistemaActual, TrashActual):-
    filesystem(_,_,_,_,_,_,_,TrashActual,_,SistemaActual).

%Descripcion: Predicado itera listado de directories en busca de directory con nombre N, retorna datos (nombre, fechas, creador, atributos) de directory.
%Dominio: NameFile(str), ListDirectories(list), CreatorUser(str), FechaCreacion(number), FechaModificacion(number), Atributos(List).
%Meta Primaria: getDatosDirectory/6
getDatosDirectory(NameFile, [[NameFile, CreatorUser, FechaCreacion, FechaModificacion, Atributos,_] | _],CreatorUser,FechaCreacion,FechaModificacion,Atributos).
%Descripcion: Predicado itera listado de directories en busca de directory con nombre N, retorna datos (nombre, fechas, creador, atributos) de directory.
%Dominio: NameFile(str), ListDirectories(list), CreatorUser(str), FechaCreacion(number), FechaModificacion(number), Atributos(List).
%Meta Primaria: getDatosDirectory/6
%Meta secundaria: getDatosDirectory/6
getDatosDirectory(NameFile, [ _ | Tail], CreatorUser, FechaCreacion, FechaModificacion, Atributos):-
    getDatosDirectory(NameFile, Tail, CreatorUser, FechaCreacion, FechaModificacion, Atributos).



%Descripcion: Predicado itera listado de directories en busca de directory con nombre N, retorna ubicacion de directory.
%Dominio: N(str),ListDirectories(list), Ubicacion(str).
%Meta Primaria: ubicacionDirectory/3
getubicacionDirectory(N, [[N,_,_,_,_,Ubicacion] | _], Ubicacion).
%Descripcion: Predicado intera listado de directories en busca de directory con nombre N, retorna ubicacion de directory.
%Dominio: N(str),ListDirectories(list), Ubicacion(str).
%Meta Primaria: ubicacionDirectory/3
%Meta Secundaria:  ubicacionDirectory/3
getubicacionDirectory(N, [ _ | OtrosDirectory], Ubicacion) :-
    getubicacionDirectory(N, OtrosDirectory, Ubicacion).

%Descripcion: Predicado itera listado de directories en busca de directory con nombre N, retorna capacidad de directory.
%Dominio: N(str),ListDirectories(list), Capacity(number).
%Meta Primaria: getCapacityDrive/3
getCapacityDrive(LetterDrive, [[LetterDrive,_,Capacity] | _],Capacity).
%Descripcion: Predicado itera listado de directories en busca de directory con nombre N, retorna capacidad de directory.
%Dominio: N(str),ListDirectories(list), Capacity(number).
%Meta Primaria: getCapacityDrive/3
%Meta Secundaria: getCapacityDrive/3
getCapacityDrive(LetterDrive, [ _ | Tail], Capacity) :-
    getCapacityDrive(LetterDrive, Tail, Capacity).












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

%Descripcion: Predicado transforma información de entregada de file (nombre y contenido), en nuevo documento file (nombre, contenido y ubicacion).
%Dominio: OriginalSystem(str),NewFile(list), RealNewFile(list).
%Meta Primaria: setOriginalFile/3
%Meta Secundaria: getRutaActual/2
%				: file/3
%				: newFile/4
setOriginalFile(OriginalSystem,NewFile,RealNewFile):-
    getRutaActual(OriginalSystem, RutaActual),
    file(NameReal,ContentReal,NewFile),
    newFile(NameReal, ContentReal, RutaActual, RealNewFile).

%Descripcion: Predicado agrega un nuevo file a un listado de files del sistema.
%Dominio: NewFile(list), OriginalFile(list), UpdateFile(list).
%Meta Primaria: setNewFile/3
%Meta Secundaria: append/3
setNewFile(NewFile,OriginalFile,UpdateFile):-
    append(OriginalFile,[NewFile],UpdateFile).

%Descripcion: Predicado unifica listado de files en uno.
%Dominio: NewFile(list), OriginalFile(list), UpdateFile(list).
%Meta Primaria: setNewListFile/3
%Meta Secundaria: append/3
setNewListFile(NewFile,OriginalFile,UpdateFile):-
    append(OriginalFile,NewFile,UpdateFile).

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

%Descripcion: Predicado unifica listado de trash.
%Dominio: NewTrash(list), OriginalTrash(list), UpdateTrash(list).
%Meta Primaria: setUnirTrash/3
%Meta Secundaria: append/3
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


%Descripcion: Predicado revisa si lista esta vacia, devuelve true o false.
%Dominio: Lista(list).
%Meta Primaria: es_login_vacio/1.
es_vacio([]).

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

%Descripcion: Predicado selecciona el primer elemento de una lista.
%Dominio: Lista(list),PrimerElemento(list).
%Meta Primaria: seleccionarPrimeraUbicacion/2
seleccionarPrimeraUbicacion([Elemento|_], Elemento).

%Descripcion: Predicado identifica si atomo ingresado corresponde a alguno de los elementos en la lista retorna true o false.
%Dominio: SimbolPath(str)
%Meta Primaria: list_simbolos_CD/1
%Meta Secundaria:  \+ member/2
list_simbolos_CD(SimbolPath):-
    \+ member(SimbolPath,["..","/", ".","./","../dir","././././"]).

%Descripcion: Predicado identifica si atomo presenta el simbolo / dentro de el listado de carecteres, retorna true o false.
%Dominio: String(str)
%Meta Primaria: slash_presente/1
%Meta Secundaria:  atom_chars/2
%				: member/2
slash_presente(String):-
    atom_chars(String, ListaCaracteres),
    member(/, ListaCaracteres).

%Descripcion: Predicado identifica si atomo presenta el simbolo / dentro de el listado de carecteres, retorna true o false.
%Dominio: String(str)
%Meta Primaria: slash_presente/1
%Meta Secundaria:  atom_chars/2
%				: member/2
cortar_string_slash(Input, String) :-
    sub_atom(Input, _, _, After, '/'),
    sub_atom(Input, _, After, 0, Atom),
    atom_string(Atom,String).

%Descripcion: Predicado identifica si atomo ingresado corresponde a alguno de los elementos en la lista retorna true o false.
%Dominio: SimbolPath(str)
%Meta Primaria: list_simbolos_mismaCarpeta/1
%Meta Secundaria:  member/2
list_simbolos_mismaCarpeta(SimbolPath):-
    member(SimbolPath,[".","./","../dir","././././"]).

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

%Descripcion: Predicado intera listado de Directories en busca de un nombre de Directory, elimina dicho Directory y retorna lista con el resto.
%Dominio: NameDirectory(str),ListDirectories(list), Resultado(str).
%Meta Primaria: borrarFile/3
borrarDiretory(NameDirectory,[[NameDirectory,_,_,_,_,_]|Resto], Resto ). 
%Descripcion: Predicado intera listado de Directories en busca de un nombre de Directory, elimina dicho Directory y retorna lista con el resto.
%Dominio: NameDirectory(str),ListDirectories(list), Resultado(str).
%Meta Primaria: borrarFile/3
%Meta Secundaria:  NombreDirectory\= /1
%				: borrarDiretory/3
borrarDiretory( NameDirectory, [Cabeza|Resto], [Cabeza|Resultado] ) :-
	NameDirectory\=Cabeza,
	borrarDiretory( NameDirectory, Resto, Resultado).

%Descripcion: Predicado intera listado de Drives en busca de un nombre de Drive, elimina dicho Drive y retorna lista con el resto.
%Dominio: LetterDrive(str),ListDrives(list), Resultado(str).
%Meta Primaria: borrarDrive/3
borrarDrive(LetterDrive,[[LetterDrive,_,_]|Resto], Resto ). 
%Descripcion: Predicado intera listado de Drives en busca de un nombre de Drive, elimina dicho Drive y retorna lista con el resto.
%Dominio: LetterDrive(str),ListDrives(list), Resultado(str).
%Meta Primaria: borrarDrive/3
%Meta Secundaria:  LetterDrive\= /1
%				: borrarDrive/3
borrarDrive( LetterDrive, [Cabeza|Resto], [Cabeza|Resultado] ) :-
	LetterDrive\=Cabeza,
	borrarDrive( LetterDrive, Resto, Resultado).



%Descripcion: Predicado identifica si Simbol corresponde a "*.*", entrega true o false.
%Dominio: Simbol(str).
%Meta Primaria: esSimboloDirectorioActual/1
%Meta Secundaria: member/2
esSimboloDirectorioActual(Simbol):-
    member(Simbol,["*.*"]).

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

%Descripcion: Predicado elimina primer elemento de una lista.
%Dominio: Lista(list),RestoLista(list).
%Meta Primaria: eliminarPrimero/2
eliminarPrimero([_|Elemento], Elemento).

%Descripcion: Predicado identifica presencia de substring en string, devuelve True o False.
%Dominio: Substring(Str),String(Str).
%Meta Primaria: substring_contenido/2
%Meta Secundaria: sub_atom/5
substring_contenido(Sub, Str) :-
    sub_atom(Str, _, _, _, Sub).

%Descripcion: Predicado elimina file desde listado de Files, que presenta substring en su nombre.
%Dominio: Substring(Str), ListadoFilesOriginal(List), ListadoFilesFinal(List).
%Meta Primaria: eliminarFileConSubstring/3
eliminarFileConSubstring(_,[], []).
%Descripcion: Predicado elimina file desde listado de Files, que presenta substring en su nombre.
%Dominio: Substring(Str), ListadoFilesOriginal(List), ListadoFilesFinal(List).
%Meta Primaria: eliminarFileConSubstring/3
%Meta Secundaria: substring_contenido/2
%				:eliminarFileConSubstring/3
eliminarFileConSubstring(Sub, [[String,_,_]|Rest], Result) :-
    substring_contenido(Sub,String), !,
    eliminarFileConSubstring(Sub, Rest, Result).
%Descripcion: Predicado elimina file desde listado de Files, que presenta substring en su nombre.
%Dominio: Substring(Str), ListadoFilesOriginal(List), ListadoFilesFinal(List).
%Meta Primaria: eliminarFileConSubstring/3
%Meta Secundaria:eliminarFileConSubstring/3
eliminarFileConSubstring(Sub, [List|Rest], [List|UpdatedRest]) :-
    eliminarFileConSubstring(Sub, Rest, UpdatedRest).

%Descripcion: Predicado busca files que presenten substring en su nombre, devuelve una lista con los Files encontrados.
%Dominio: Substring(Str), ListadoFilesOriginal(List), ListadoFilesConsubstring(List).
%Meta Primaria: buscarFileConSubstring/3
buscarFileConSubstring(_,[], []).
%Descripcion: Predicado busca files que presenten substring en su nombre, devuelve una lista con los Files encontrados.
%Dominio: Substring(Str), ListadoFilesOriginal(List), ListadoFilesConsubstring(List).
%Meta Primaria	: buscarFileConSubstring/3
%Meta Secundaria:\+ substring_contenido/2
%				: buscarFileConSubstring/3
buscarFileConSubstring(Sub, [[String,_,_]|Rest], Result) :-
    \+ substring_contenido(Sub,String), !,
    buscarFileConSubstring(Sub, Rest, Result).
%Descripcion: Predicado busca files que presenten substring en su nombre, devuelve una lista con los Files encontrados.
%Dominio: Substring(Str), ListadoFilesOriginal(List), ListadoFilesConsubstring(List).
%Meta Primaria	: buscarFileConSubstring/3
%Meta Secundaria: buscarFileConSubstring/3
buscarFileConSubstring(Sub, [List|Rest], [List|UpdatedRest]) :-
    buscarFileConSubstring(Sub, Rest, UpdatedRest).

%Descripcion: Predicado selecciona el ultimo elemento de una lista, recorriendo a esta.
%Dominio: Lista(List), UltimoElemento(Str).
%Meta Primaria	: ultimo_elemento/2
ultimo_elemento([X], X). 
%Descripcion: Predicado selecciona el ultimo elemento de una lista, recorriendo a esta.
%Dominio: Lista(List), UltimoElemento(Str).
%Meta Primaria	: ultimo_elemento/2
%Meta Secundaria: ultimo_elemento/2
ultimo_elemento([_|Resto], Ultimo) :-
    ultimo_elemento(Resto, Ultimo).

%Descripcion: Predicado selecciona file que presenten ubicacion indicada y crea un listado de estos.
%Dominio: Ubicacion(Str), ListFiles(List), ListResultados(List).
%Meta Primaria	: listFileConUbicacion/3
listFileConUbicacion(_,[], []).
%Descripcion: Predicado selecciona file que presenten ubicacion indicada y crea un listado de estos.
%Dominio: Ubicacion(Str), ListFiles(List), ListResultados(List).
%Meta Primaria	: listFileConUbicacion/3
%Meta Secundaria: \+ existe/2
%				: listFileConUbicacion/3
listFileConUbicacion(Ubicacion, [[_,_,Ruta]|Rest],Result) :-
    \+ existe(Ubicacion,Ruta), !,
    listFileConUbicacion(Ubicacion, Rest, Result).
%Descripcion: Predicado selecciona file que presenten ubicacion indicada y crea un listado de estos.
%Dominio: Ubicacion(Str), ListFiles(List), ListResultados(List).
%Meta Primaria	: listFileConUbicacion/3
%Meta Secundaria: listFileConUbicacion/3
listFileConUbicacion(Ubicacion, [List|Rest], [List|UpdatedRest]) :-
    listFileConUbicacion(Ubicacion, Rest, UpdatedRest).


%Descripcion: Predicado selecciona file que presenten ubicaciones diferentes a ubicación indicada y crea una lista con estos.
%Dominio: Ubicacion(Str), ListFiles(List), ListResultados(List).
%Meta Primaria	: listFileSinUbicacion/3
listFileSinUbicacion(_,[], []).
%Descripcion: Predicado selecciona file que presenten ubicaciones diferentes a ubicación indicada y crea una lista con estos.
%Dominio: Ubicacion(Str), ListFiles(List), ListResultados(List).
%Meta Primaria	: listFileSinUbicacion/3
%Meta Secundaria: existe/2
%				: listFileSinUbicacion/3
listFileSinUbicacion(Ubicacion, [[_,_,Ruta]|Rest],Result) :-
    existe(Ubicacion,Ruta), !,
    listFileSinUbicacion(Ubicacion, Rest, Result).
%Descripcion: Predicado selecciona file que presenten ubicaciones diferentes a ubicación indicada y crea una lista con estos.
%Dominio: Ubicacion(Str), ListFiles(List), ListResultados(List).
%Meta Primaria	: listFileSinUbicacion/3
%Meta Secundaria: listFileSinUbicacion/3
listFileSinUbicacion(Ubicacion, [List|Rest], [List|UpdatedRest]) :-
    listFileSinUbicacion(Ubicacion, Rest, UpdatedRest).

%Descripcion: Predicado selecciona Directory que presenten ubicacion indicada y crea un listado de estos.
%Dominio: Ubicacion(Str), ListDirectory(List), ListResultados(List).
%Meta Primaria	: listDirectoryConUbicacion/3
listDirectoryConUbicacion(_,[], []).
%Descripcion: Predicado selecciona Directory que presenten ubicacion indicada y crea un listado de estos.
%Dominio: Ubicacion(Str), ListDirectory(List), ListResultados(List).
%Meta Primaria	: listDirectoryConUbicacion/3
%Meta Secundaria: \+ existe/2
%				: listDirectoryConUbicacion/3
listDirectoryConUbicacion(Ubicacion, [[_,_,_,_,_,Ruta]|Rest],Result) :-
    \+ existe(Ubicacion,Ruta), !,
    listDirectoryConUbicacion(Ubicacion, Rest, Result).
%Descripcion: Predicado selecciona Directory que presenten ubicacion indicada y crea un listado de estos.
%Dominio: Ubicacion(Str), ListDirectory(List), ListResultados(List).
%Meta Primaria	: listDirectoryConUbicacion/3
%Meta Secundaria: listDirectoryConUbicacion/3
listDirectoryConUbicacion(Ubicacion, [List|Rest], [List|UpdatedRest]) :-
    listDirectoryConUbicacion(Ubicacion, Rest, UpdatedRest).

%Descripcion: Predicado selecciona Directory que NO presenten ubicacion indicada y crea un listado de estos.
%Dominio: Ubicacion(Str), ListDirectory(List), ListResultados(List).
%Meta Primaria	: listDirectorySinUbicacion/3
listDirectorySinUbicacion(_,[], []).
%Descripcion: Predicado selecciona Directory que NO presenten ubicacion indicada y crea un listado de estos.
%Dominio: Ubicacion(Str), ListDirectory(List), ListResultados(List).
%Meta Primaria	: listDirectorySinUbicacion/3
%Meta Secundaria: existe/2
%				: listDirectorySinUbicacion/3
listDirectorySinUbicacion(Ubicacion, [[_,_,_,_,_,Ruta]|Rest],Result) :-
    existe(Ubicacion,Ruta), !,
    listDirectorySinUbicacion(Ubicacion, Rest, Result).
%Descripcion: Predicado selecciona Directory que NO presenten ubicacion indicada y crea un listado de estos.
%Dominio: Ubicacion(Str), ListDirectory(List), ListResultados(List).
%Meta Primaria	: listDirectorySinUbicacion/3
%Meta Secundaria: listDirectorySinUbicacion/3
listDirectorySinUbicacion(Ubicacion, [List|Rest], [List|UpdatedRest]) :-
    listDirectorySinUbicacion(Ubicacion, Rest, UpdatedRest).





%Descripcion: Predicado identifica si string presenta un punto dentro de sus carácteres.
%Dominio: String(Str).
%Meta Primaria	: punto_presente/1
%Meta Secundaria: atom_chars/2
%				: member/2
punto_presente(String):-
    atom_chars(String, ListaCaracteres),
    member(., ListaCaracteres).

%Descripcion: Predicado recibe string y devuelve la primera letra de éste.
%Dominio: String(Str), Drive(str)
%Meta Primaria	: primeraLetra/2
%Meta Secundaria: sub_atom/5
%				: atom_string/2
primeraLetra(String, Drive):-
    sub_atom(String,0,1,_,Letra),
    atom_string(Letra,Drive).

%Descripcion: Predicado recibe string ruta de archivo con formato entre /, devuelve string.
%Dominio: Input(Str), String(str)
%Meta Primaria	: cortar_ruta_entreslash/2
%Meta Secundaria: sub_atom/5
%				: atom_string/2
cortar_ruta_entreslash(Input, String) :-
    sub_atom(Input, 3, _, 1, Atom),
    atom_string(Atom,String).

%Descripcion: Predicado recibe ruta en formato string, lo transforma a lista.
%Dominio: Ruta(Str), CambioRuta(List)
%Meta Primaria	: crearRuta/2
%Meta Secundaria: primeraLetra/2
%				: cortar_ruta_entreslash/2
%				: CambioRuta/2
crearRuta(Ruta, CambioRuta):-
    primeraLetra(Ruta, Drive),
    cortar_ruta_entreslash(Ruta, Folder),
    CambioRuta = [Drive , Folder].

%Descripcion: Predicado cambia ubicacion a lista de Files.
%Dominio: Ruta(Str), ListFilesOriginales(List),ListFilesNewRuta(List)
%Meta Primaria	: cambiarUbicacionFiles/3
cambiarUbicacionFiles(_,[],NuevaLista,NuevaLista).
%Descripcion: Predicado cambia ubicacion a lista de Files.
%Dominio: Ruta(Str), ListFilesOriginales(List),ListFilesNewRuta(List)
%Meta Primaria	: cambiarUbicacionFiles/3
%Meta Secundaria: eliminarUltimaUbicacion/2
%				: append/3
%				: cambiarUbicacionFiles/3
cambiarUbicacionFiles(NewRuta,[File| Rest],NuevaLista, Final):-
    eliminarUltimaUbicacion(File, NewFile),
    append(NewFile,[NewRuta], FileConNewRuta),
    cambiarUbicacionFiles(NewRuta, Rest, [FileConNewRuta|NuevaLista], Final).


%Descripcion: Recibe nombre de busqueda archivo en formato nombre_ubicacion/inicio_nombre, devuelde nombre ubicacion.
%Dominio: NameFileCopy(Str), String(Str).
%Meta Primaria	: directorioDeBusqueda/2
%Meta Secundaria: sub_atom/5
%				: sub_atom/5
%				: atom_string/2
directorioDeBusqueda(NameFileCopy, String) :-
    sub_atom(NameFileCopy, BeforeSymbol, _, _, "/"),
    sub_atom(NameFileCopy, 0, BeforeSymbol, _, Substring),
    atom_string(Substring,String).

%Descripcion: Recibe nombre de busqueda archivo en formato nombre_ubicacion/inicio_nombre, devuelve inicio de file para buscar.
%Dominio: NameFileCopy(Str), String(Str).
%Meta Primaria	: substringBusqueda/2
%Meta Secundaria: sub_atom/5
%				: sub_atom/5
%				: atom_string/2
substringBusqueda(NameFileCopy,String):-
    sub_atom(NameFileCopy, _,_, AfterSymbol, "/"),
    sub_atom(NameFileCopy, _, AfterSymbol, 0, Substring),
    atom_string(Substring,String).

%Descripcion: Unifica listado de files y directories.
%Meta Primaria	: listar/2
listar(Files, Directory,[Files, Directory]).


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
    es_vacio(OriginalUser),
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
    \+ es_vacio(UserActual),
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
    \+ es_vacio(UserActual),
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
    setSystemDriveActual(OriginalSystem,[NewRuta],UpdateSystem).

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
    getubicacionDirectory(NameDirectory,DirectoryActuales,Ubicacion),
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
    getubicacionDirectory(NewNameDirectory,DirectoryActuales,Ubicacion),
    append(Ubicacion, [NewNameDirectory], RutaNew),
    setSystemDriveActual(OriginalSystem,RutaNew,UpdateSystem).

%Descripcion: Predicado reconoce simbolos (".","./","../dir","././././")  y mantiene la misma ruta del filesystem anterior.
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
%Descripcion: Predicado reconoce nombre de File y lo elimina del sistema.
%Dominio: OriginalSystem(list) X NameFileDeleted(str) X UpdateSystem(list).
%Meta Primaria: systemDel/3
%Meta Secundaria: \+ asteristo_inicial/1
%				: getFiles/1
%				: getContenidoFile/1
%				: getRutaFile/3
%				: newFile/4
%				: getTrash/2
%				: setNewTrash/3
%				: setSystemTrash/3
%				: borrarFile/3
%				: setSystemFiles/3
systemDel(OriginalSystem,NameFileDeleted,UpdateSystem):-
    \+ asteristo_inicial(NameFileDeleted),
    getFiles(OriginalSystem, ListFiles),
   	getContenidoFile(NameFileDeleted,ListFiles,ContentFileDeleted),
    getRutaFile(NameFileDeleted,ListFiles,RutaFileDeleted),
    newFile(NameFileDeleted, ContentFileDeleted,RutaFileDeleted,FileTrash),
    getTrash(OriginalSystem, OriginalTrash),
    setNewTrash(FileTrash,OriginalTrash,UpdateTrash),
    setSystemTrash(OriginalSystem,UpdateTrash,TemporalSystem),
    borrarFile(NameFileDeleted,ListFiles,NewFilesActuales),
    setSystemFiles(TemporalSystem, NewFilesActuales,UpdateSystem).


%Descripcion: Predicado reconoce extension despues de * y elimina todos los Files con dicha extension desde el sistema.
%Dominio: OriginalSystem(list) X NameFileDeleted(str) X UpdateSystem(list).
%Meta Primaria: systemDel/3
%Meta Secundaria: asteristo_inicial/1
%				: \+ esSimboloDirectorioActual/1
%				: quitarAsterico/2
%				: getFiles/2
%				: eliminarFileConSubstring/3
%				: buscarFileConSubstring/3
%				: getTrash/2
%				: setUnirTrash/3
%				: setSystemTrash/3
%				: setSystemFiles/3
systemDel(OriginalSystem,NameFileDeleted,UpdateSystem):-
    asteristo_inicial(NameFileDeleted),
    \+ esSimboloDirectorioActual(NameFileDeleted),
    quitarAsterico(NameFileDeleted,ExtensionDeleted),
    getFiles(OriginalSystem, ListFiles),
	eliminarFileConSubstring(ExtensionDeleted,ListFiles,NewListFile),
    buscarFileConSubstring(ExtensionDeleted,ListFiles,TrashListFile),
    getTrash(OriginalSystem, OriginalTrash),
    setUnirTrash(TrashListFile,OriginalTrash,UpdateTrash),
    setSystemTrash(OriginalSystem,UpdateTrash,TemporalSystem),
    setSystemFiles(TemporalSystem, NewListFile,UpdateSystem).

%Descripcion: Predicado reconoce simbolo *.* y elimina todos los archivos del directorio actual.
%Dominio: OriginalSystem(list) X NameFileDeleted(str) X UpdateSystem(list).
%Meta Primaria: systemDel/3
%Meta Secundaria: esSimboloDirectorioActual/1
%				: getRutaActual/2
%				: ultimo_elemento/2
%				: getFiles/2
%				: listFileConUbicacion/3
%				: listFileSinUbicacion/3
%				: getTrash/2
%				: setUnirTrash/3
%				: setSystemTrash/3
%				: setSystemFiles/3
systemDel(OriginalSystem,NameFileDeleted,UpdateSystem):-
    esSimboloDirectorioActual(NameFileDeleted),
    getRutaActual(OriginalSystem, RutaActual),
    ultimo_elemento(RutaActual, UltimaUbicacion),
    getFiles(OriginalSystem, ListFiles),
    listFileConUbicacion(UltimaUbicacion, ListFiles, ListFileTrash),
    listFileSinUbicacion(UltimaUbicacion, ListFiles, NewListFile),
    getTrash(OriginalSystem, OriginalTrash),
    setUnirTrash(ListFileTrash,OriginalTrash,UpdateTrash),
    setSystemTrash(OriginalSystem,UpdateTrash,TemporalSystem),
    setSystemFiles(TemporalSystem, NewListFile,UpdateSystem).
    
%Descripcion: Predicado borra carpeta segun el nombre indicado desde el sistema actual.
%Dominio: OriginalSystem(list) X NameFileDeleted(str) X UpdateSystem(list).
%Meta Primaria: systemDel/3
%Meta Secundaria: \+ punto_presente/1
%				: \+ asteristo_inicial/1
%				: getDirectory/2
%				: getDatosDirectory/6
%				: getRutaDirectory/3
%				: directory/7
%				: getTrash/2
%				: setNewTrash/3
%				: setSystemTrash/3
%				: borrarDiretory/3
%				: setSystemFiles/3
systemDel(OriginalSystem,NameFileDeleted,UpdateSystem):-
    \+ punto_presente(NameFileDeleted),
    \+ asteristo_inicial(NameFileDeleted),
    getDirectory(OriginalSystem, DirectoryActuales),
    getDatosDirectory(NameFileDeleted, DirectoryActuales, CreatorUser, FechaCreacion, FechaModificacion,Atributos),
    getubicacionDirectory(NameFileDeleted, DirectoryActuales, RutaDirectory),
    directory(NameFileDeleted, CreatorUser, FechaCreacion, FechaModificacion, Atributos, RutaDirectory, DirectoryTrash),
   	getTrash(OriginalSystem, OriginalTrash),
    setNewTrash(DirectoryTrash,OriginalTrash,UpdateTrash),
    setSystemTrash(OriginalSystem,UpdateTrash,TemporalSystem),
    borrarDiretory(NameFileDeleted,DirectoryActuales, NewDirectoryActuales),
    setSystemDirectories(TemporalSystem,NewDirectoryActuales,UpdateSystem).


%F11: TDA system-Copy
%Descripcion: Predicado copia File en directorio indicado.
%Dominio: OriginalSystem(list) X NameFileCopy(str) X NameNewRuta (str) X UpdateSystem(list).
%Meta Primaria: systemCopy/3
%Meta Secundaria: \+ slash_presente/1
%				: punto_presente/1
%				: \+ asteristo_inicial/1
%				: getFiles/2
%				: getContenidoFile/3
%				: crearRuta/2
%				: newFile/4
%				: setNewFile/3
%				: setSystemFiles/3
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

%Descripcion: Predicado copia Carpeta en directorio indicado.
%Dominio: OriginalSystem(list) X NameFileCopy(str) X NameNewRuta (str) X UpdateSystem(list).
%Meta Primaria: systemCopy/3
%Meta Secundaria: \+ slash_presente/1
%				: \+ punto_presente/1
%				: \+ asteristo_inicial/1
%				: getDirectory/2
%				: getDatosDirectory/6
%				: crearRuta/2
%				: directory/7
%				: setNewDirectory/3
%				: setSystemDirectories/3
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

%Descripcion: Predicado copia Files que presenten extension indicada despues del * en ruta indicada.
%Dominio: OriginalSystem(list) X NameFileCopy(str) X NameNewRuta (str) X UpdateSystem(list).
%Meta Primaria: systemCopy/3
%Meta Secundaria: \+ slash_presente/1
%				: asteristo_inicial/1
%				: quitarAsterico/2
%				: getFiles/2
%				: buscarFileConSubstring/3
%				: crearRuta/2
%				: cambiarUbicacionFiles/4
%				: setNewListFile/3
%				: setSystemFiles/3
systemCopy(OriginalSystem,NameFileCopy,NewRuta,UpdateSystem):-
    \+ slash_presente(NameFileCopy),
    asteristo_inicial(NameFileCopy),
    quitarAsterico(NameFileCopy,ExtensionCopy),
    getFiles(OriginalSystem, ListFiles),
    buscarFileConSubstring(ExtensionCopy,ListFiles,NewListFile),
    crearRuta(NewRuta, CambioRuta),
    cambiarUbicacionFiles(CambioRuta,NewListFile,[],NuevaLista),
    setNewListFile(NuevaLista,ListFiles,UpdateFile),
    setSystemFiles(OriginalSystem, UpdateFile,UpdateSystem).


%Descripcion: Predicado recibe nombre de archivo para copiar con formato nombre_ubicacion/inicio_nombre, se buscar archivo correspondiente y se copia a ruta indicada.
%Dominio: OriginalSystem(list) X NameFileCopy(str) X NameNewRuta (str) X UpdateSystem(list).
%Meta Primaria: systemCopy/3
%Meta Secundaria: slash_presente/1
%				: directorioDeBusqueda/2
%				: substringBusqueda/2
%				: getFiles/2
%				: listFileConUbicacion/3
%				: buscarFileConSubstring/3
%				: crearRuta/2
%				: cambiarUbicacionFiles/4
%				: setNewListFile/3
%				: setSystemFiles/3
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
%Descripcion: Predicado recibe nombre de archivo y lo mueve a la ruta indicada.
%Dominio: OriginalSystem(list) X NameFileCopy(str) X NameNewRuta (str) X UpdateSystem(list).
%Meta Primaria: systemMove/4
%Meta Secundaria: punto_presente/1
%				: getFiles/2
%				: getContenidoFile/3
%				: crearRuta/2
%				: newFile/4
%				: borrarFile/3
%				: setNewFile/3
%				: setSystemFiles/3
systemMove(OriginalSystem,NameFileCopy,NewRuta,UpdateSystem):-
    punto_presente(NameFileCopy),
    getFiles(OriginalSystem, ListFiles),
    getContenidoFile(NameFileCopy,ListFiles,ContentFile),
    crearRuta(NewRuta, CambioRuta),
   	newFile(NameFileCopy, ContentFile,CambioRuta,FileCopy),
    borrarFile(NameFileCopy,ListFiles,NewFilesActuales),
    setNewFile(FileCopy,NewFilesActuales,UpdateFile),
    setSystemFiles(OriginalSystem, UpdateFile,UpdateSystem).

%Descripcion: Predicado recibe nombre de Directory y lo mueve a la ruta indicada.
%Dominio: OriginalSystem(list) X NameFileCopy(str) X NameNewRuta (str) X UpdateSystem(list).
%Meta Primaria: systemMove/4
%Meta Secundaria: \+ punto_presente/1
%				: getDirectory/2
%				: getDatosDirectory/6
%				: crearRuta/2
%				: directory/7
%				: borrarDiretory/3
%				: setNewDirectory/3
%				: setSystemDirectories/3
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
%Descripcion: Predicado recibe nombre de archivo(File) y lo cambia por otro.
%Dominio: OriginalSystem(list) X OriginalName(str) X NewName (str) X UpdateSystem(list).
%Meta Primaria: systemRen/4
%Meta Secundaria: punto_presente/1
%				: getFiles/2
%				: getContenidoFile/3
%				: getRutaFile/3
%				: newFile/3
%				: borrarFile/3
%				: setNewFile/3
%				: setSystemFiles/3
systemRen(OriginalSystem, OriginalName, NewName, UpdateSystem):-
    punto_presente(OriginalName),
    getFiles(OriginalSystem, ListFiles),
    getContenidoFile(OriginalName,ListFiles,ContentFile),
    getRutaFile(OriginalName,ListFiles,RutaFile),
   	newFile(NewName, ContentFile,RutaFile,FileNewName),
    borrarFile(OriginalName,ListFiles,NewFilesActuales),
    setNewFile(FileNewName,NewFilesActuales,UpdateFile),
    setSystemFiles(OriginalSystem, UpdateFile,UpdateSystem).

%Descripcion: Predicado recibe nombre de carpeta(Directory) y lo cambia por otro.
%Dominio: OriginalSystem(list) X OriginalName(str) X NewName (str) X UpdateSystem(list).
%Meta Primaria: systemRen/4
%Meta Secundaria: \+ punto_presente/1
%				: getDirectory/2
%				: getDatosDirectory/6
%				: getubicacionDirectory/3
%				: directory/7
%				: borrarDiretory/3
%				: setNewDirectory/3
%				: setSystemDirectories/3
systemRen(OriginalSystem, OriginalName, NewName, UpdateSystem):-
    \+ punto_presente(OriginalName),
    getDirectory(OriginalSystem, DirectoryActuales),
    getDatosDirectory(OriginalName, DirectoryActuales, CreatorUser, FechaCreacion, FechaModificacion,Atributos),
    getubicacionDirectory(OriginalName, DirectoryActuales, RutaDirectory),
    directory(NewName, CreatorUser, FechaCreacion, FechaModificacion, Atributos, RutaDirectory, DirectoryNewName),
    borrarDiretory(OriginalName,DirectoryActuales,NewDirectoryActuales),
    setNewDirectory(DirectoryNewName, NewDirectoryActuales, UpdateDirectories),
   	setSystemDirectories(OriginalSystem,UpdateDirectories,UpdateSystem).

%F14: TDA system-dir (directory)
%Descripcion: Predicado recibe el parametro [] que indica que se debe listar el contenido del directorio actual.
%Dominio: OriginalSystem(list) X Params(str) X Str (str).
%Meta Primaria: systemDir/3
%Meta Secundaria: es_vacio/1
%				: getRutaActual/2
%				: ultimo_elemento/2
%				: getFiles/2
%				: listFileConUbicacion/3
%				: getDirectory/2
%				: listDirectoryConUbicacion/3
%				: Files/1
%				: Directory/1
%				: listar/3
systemDir(OriginalSystem, Params, Str):-
    es_vacio(Params),
    getRutaActual(OriginalSystem, RutaActual),
    ultimo_elemento(RutaActual, UltimaUbicacion),
    getFiles(OriginalSystem, ListFiles),
    listFileConUbicacion(UltimaUbicacion, ListFiles, FilesEnDirectory),
    getDirectory(OriginalSystem, DirectoryActuales),
    listDirectoryConUbicacion(UltimaUbicacion, DirectoryActuales, DirectoryEnUbicacion),
    Files = FilesEnDirectory,
    Directory = DirectoryEnUbicacion,
    listar(Files, Directory, Str).

%F15: TDA system-format
%Descripcion: Predicado recibe nombre de drive, y formatea, eliminando todos los documentos presentes en dicha unidad, crea nuevo drive con otro nombre.
%Dominio: OriginalSystem(list) X LetterDrive(str) X NewName (str) X UpdateSystem(list).
%Meta Primaria: systemFormat/4
%Meta Secundaria: getDrives/2
%				: listaLetter/2
%				: member/2
%				: getCapacityDrive/3
%				: drive/4
%				: borrarDrive/3
%				: setaddDrives/3
%				: setSystemNewDrives/3
%				: getFiles/2
%				: listFileSinUbicacion/3
%				: getDirectory/2
%				: listDirectorySinUbicacion/3
%				: setSystemFiles/3
%				: setSystemDirectories/3
%				: setSystemDriveActual/3
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

%F20: TDA system-restore
%Descripcion: Predicado recibe nombre de archivos que se encentran en la papelera y los restituye a su ubicacion original.
%Dominio: OriginalSystem(list) X FileName (str) X UpdateSystem(list).
%Meta Primaria: systemRestore/3
%Meta Secundaria: \+ esSimboloDirectorioActual/1
%				: punto_presente/1
%				: getTrash/2
%				: getContenidoFile/3
%				: getRutaFile/3
%				: newFile/3
%				: getFiles/2
%				: setNewFile/3
%				: setSystemFiles/2
systemRestore(OriginalSystem, FileName, UpdateSystem):-
    \+ esSimboloDirectorioActual(FileName),
    punto_presente(FileName),
    getTrash(OriginalSystem, OriginalTrash),
    getContenidoFile(FileName,OriginalTrash,ContentFile),
    getRutaFile(FileName,OriginalTrash,RutaFile),
    newFile(FileName, ContentFile,RutaFile,FileNewName),
    getFiles(OriginalSystem, ListFiles),
    setNewFile(FileNewName,ListFiles,UpdateFile),
    setSystemFiles(OriginalSystem, UpdateFile,UpdateSystem).

%Descripcion: Predicado recibe nombre de Directories que se encentran en la papelera y los restituye a su ubicacion original.
%Dominio: OriginalSystem(list) X DirectoryName (str) X UpdateSystem(list).
%Meta Primaria: systemRestore/3
%Meta Secundaria: \+ esSimboloDirectorioActual/1
%				: \+ punto_presente/1
%				: getTrash/2
%				: getDatosDirectory/6
%				: getubicacionDirectory/3
%				: directory/7
%				: getDirectory/2
%				: setNewDirectory/3
%				: setSystemDirectories/3
systemRestore(OriginalSystem, DirectoryName, UpdateSystem):-
    \+ esSimboloDirectorioActual(DirectoryName),
    \+ punto_presente(DirectoryName),
    getTrash(OriginalSystem, OriginalTrash),
    getDatosDirectory(DirectoryName, OriginalTrash, CreatorUser, FechaCreacion, FechaModificacion,Atributos),
    getubicacionDirectory(DirectoryName, OriginalTrash, RutaDirectory),
    directory(DirectoryName, CreatorUser, FechaCreacion, FechaModificacion, Atributos, RutaDirectory, DirectoryNewName),
    getDirectory(OriginalSystem, DirectoryActuales),
    setNewDirectory(DirectoryNewName, DirectoryActuales, UpdateDirectories),
   	setSystemDirectories(OriginalSystem,UpdateDirectories,UpdateSystem).
