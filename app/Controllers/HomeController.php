<?php declare(strict_types=1);

namespace app\Controllers;

use app\Core\Controller;
use app\Controllers\AuthController;
use app\Models\Client;
use app\Models\ClientDAO;

class HomeController extends Controller {
    private $data = [];
    
    public function __construct() {
        
        if (!AuthController::isLogged()) {
            header("Location: ".BASE_URL."/auth");
        }
    }

    public function index() {
        $viewPath = 'home/';
        $viewName = "home";
        
        $client = new ClientDAO();
           
           // checa token na tabela e traz dados do client
        $this->data['client'] = $client->getClient(AuthController::getClientId()) ?? new \stdClass;
           
        $this->loadTemplate($viewPath, $viewName, $this->data);

    }
}
