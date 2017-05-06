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
        this.estado = false;
        try {
            this.validarCampos();

            var usuario = usuarioService.getUsuarioByNombre(this.textoNombre);

            if(usuario.validarContrasenia(this.textoContrasenia)){
                this.estado = true;
                usuarioService.putLog(usuario, this.estado);
                usuarioService.logIn(usuario);
                $state.go('busqueda');
            }
            else{
                usuarioService.putLog(usuario, this.estado);
                throw "La contraseña no es correcta";
            }       
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
