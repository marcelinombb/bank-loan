<?php declare(strict_types=1);

namespace app\Controllers;

use app\Core\Controller;
use app\Models\ClientDAO;
use app\Models\Client;

class ClientController extends Controller {
    
    public function __construct() {
        if (!AuthController::isLogged()):
            header("Location: " . BASE_URL . "/auth");
        endif;
    }
    
    public function index() {
        $viewPath = 'client/';
        $viewName = "home";
        
        $data = [];
        
        $this->loadView($viewPath, $viewName, $data);
    }

}?>