<?php declare(strict_types=1);
namespace app\Controllers;

use app\Core\Controller;
use app\Models\Auth;

class AuthController extends Controller {

    public function login() {
        $form = json_decode(file_get_contents('php://input'), true);
        $cpf = filter_var($form['cpf'], FILTER_SANITIZE_STRING);
        $pass = filter_var($form['pass'], FILTER_SANITIZE_STRING);

        $data = ['success' => "false"];

        if ($pass && $pass) {
            $auth = new Auth();

            $data['success'] = $auth->validateAuth($cpf, $pass);
        }

        echo json_encode($data);
    }

    public function logout() {
        unset($_SESSION['client_token']);
        header("Location:" . BASE_URL . "/home/index");
        exit;
    }
}
