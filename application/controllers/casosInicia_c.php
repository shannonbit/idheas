<?php

class casosInicia_c extends CI_Controller {
    
    function __construct() {
        parent::__construct();
        $this->load->model(array('actores_m', 'casos_m', 'catalogos_m'));
    }
/**Las siguientes funciones pertenecen a la parte de informacion de la sección de casos**/

    function index() /***Funcion que carga los detallaes del lugar***/
	{
		$this->load->helper(array('html', 'url'));					
		
				$DatosGenerales['lugares']= $this->catalogos_m->mTraerDatosCatalogoPaises();
				$DatosGenerales['relacionActorIndCol']= $this->catalogos_m->mTraerDatosCatalogoNombre('relacionActoresCatalogo');
				

		$this->load->view('formularios/formRelEntreIndividuaColectivo_v',$DatosGenerales);
	
		
	}
	
	
	
    function SeguimientoCaso() /**función que carga el seguimiento de casos**/
	{
		$this->load->helper(array('html', 'url'));					
		
		$this->load->view('casos/formularioSeguimientoCaso_v');
	}

/**Terminan las funciones que pertenecen a la parte de información general de la sección de casos**/	
}


?>
