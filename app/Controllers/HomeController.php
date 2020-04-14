<?php declare(strict_types=1);

namespace app\Controllers;

use app\Core\Controller;

class HomeController extends Controller {
    private $data = [];

    public function index() {
        $viewPath = 'home/';
        $viewName = "index";

       $client = new \stdClass;
       $client->nome = "Fulano";
       $client->email = "fulano@mail.com";

        $this->data['client_list'] = $client;
        
        $this->loadTemplate($viewPath, $viewName, $this->data);
    }
}
