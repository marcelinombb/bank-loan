<?php declare(strict_types=1);

namespace app\Controllers;

use app\Core\Controller;

class HomeController extends Controller {
    private $data = [];

    public function index() {
        $viewPath = 'home/';
        $viewName = "index";
        
        $this->loadTemplate($viewPath, $viewName, $this->data);
    }

    public function home() {
        $viewPath = 'home/';
        $viewName = "home";

       if (!empty($_SESSION['client_token'])) {
           // checa token na tabela e traz dados do client
           // $client->getClient($session_token)
            $client = new \stdClass;
            $client->name = "Fulano";
            $client->surname = "Sicrano";

            $this->data['client'] = $client;

            $this->loadTemplate($viewPath, $viewName, $this->data);
       } else {
            header("Location: ".BASE_URL);
       }
    }
}
