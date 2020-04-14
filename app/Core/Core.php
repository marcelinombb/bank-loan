<?php

namespace app\Core;

class Core {

    private $url;
    private $route;
    private $params = [];
    private $controller;
    private $action;
    private $nameSpace = '\app\\Controllers\\';

    // verifica se existe uma variavel url no verbo GET e trata a string
    private function parseUrl() {
        $this->url = rtrim(filter_input(INPUT_GET, "url", FILTER_SANITIZE_STRING));

        if ($this->url):
            $this->url = explode("/", $this->url);
        else:
            $this->url = null;
        endif;

        return $this->url;
    }

    // Trata a rota informada na url e chamada a classe, método e parametros informados.
    private function makeRoute() {

        if ($this->parseUrl()) {

            $this->controller = strtolower(array_shift($this->url)) . "Controller";

            if (isset($this->url[0]) && !empty($this->url[0])) {
                $this->action = array_shift($this->url);
            } else {
                $this->action = "index";
            }

            if (!empty($this->url)) {
                $this->params = $this->url;
            }
        } else {
            $this->controller = "HomeController";
            $this->action = "index";
        }

        $this->controller = ucfirst($this->controller);
    }

    public function run() {
        $this->makeRoute();

        // verifica pela existencia do arquivo da classe e do méthodo da classe
        if ((!file_exists('app/Controllers/' . $this->controller . '.php')) || (!method_exists($this->nameSpace . $this->controller, $this->action))) {
            $this->controller = 'NotfoundController';
            $this->action = 'index';
        }

        $this->controller = $this->nameSpace . $this->controller;

        // será chamado o controller, método e paramametro passados na url
        call_user_func_array(array(new $this->controller(), $this->action), $this->params);
    }

}