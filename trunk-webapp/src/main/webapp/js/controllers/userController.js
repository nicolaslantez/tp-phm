function UserController($state, usuarioService, localStorageService) {
    this.usuario = usuarioService.usuarioActivo;
    this.textoNombre = "";
    this.textoContrasenia = "";

    this.validarCampos = function() {
        if (this.textoNombre == "" && this.textoContrasenia == "")
            throw "Ingrese un nombre de usuario y una contraseña";

        if (this.textoNombre == "")
            throw "Ingrese un nombre";

        if (this.textoContrasenia == "")
            throw "Ingrese una contraseña";
    };

    this.logIn = function() {
        this.errorMessage = "";
        try {
            this.validarCampos();

            var usuario = usuarioService.getUsuarioByNombre(this.textoNombre);
            usuario.validarContrasenia(this.textoContrasenia);
            usuarioService.logIn(usuario);

            $state.go('busqueda');
        } catch (exception) {
            this.errorMessage = exception;
        }
    };

   this.logOut = function() {
        usuarioService.logIn();
        $state.go('login');
    };
    
    if(!this.usuario){
    	this.logOut();
    }
};
