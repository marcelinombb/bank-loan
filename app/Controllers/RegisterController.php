<?php 
declare(strict_types=1);
namespace app\Controllers;

use app\Core\Controller;
use app\Models\Register;

/**
 * 
 */
class RegisterController extends Controller
{
	public function register(){
		$form = json_decode(file_get_contents('php://input'), true);
		$name = filter_var($form['name'],FILTER_SANITIZE_STRING);
		$cpf = filter_var($form['cpf'], FILTER_SANITIZE_STRING);
        $pass = filter_var($form['pass'], FILTER_SANITIZE_STRING);

        $register = new Register();
        if($register->signUp($name,$cpf,$pass)){
        	echo "cadastrado";
        }else{
        	echo "não cadastrado";
        }
        
	}
}

 ?>