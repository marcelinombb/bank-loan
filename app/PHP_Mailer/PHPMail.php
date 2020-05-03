<?php

namespace app\PHP_Mailer;

use PHPMailer\PHPMailer\PHPMailer;
use PHPMailer\PHPMailer\SMTP;
use PHPMailer\PHPMailer\Exception;

require 'vendor/autoload.php';

class PHPMail{
	public function sendEmail($body = "teste"){
		try {
			//Configuração de servidor SMTP GOOGLE
			$mail = new PHPMailer(true);
			$mail->CharSet = "UTF-8";
			$mail->isSMTP();
			$mail->Host = 'smtp.gmail.com';
			$mail->SMTPAuth = true;
			$mail->SMTPSecure = 'tls';
			$mail->Username = 'marcelinomatheus65@gmail.com';
			$mail->Password = 'macacogordo';
			$mail->Port = 587;

			//Configuração remetente destinatario
			$mail->setFrom("marcelinomatheus65@gmail.com");
			$mail->addAddress("marcelinobraga@alunos.ifce.edu.br");

			//Configuração da mensagem
			$mail->isHTML(true);
			$mail->Subject = 'Recuperação de Senha <strong>Bank-Loan</strong>';
			$mail->Body    = "Senha requisitada <h3>$body!</h3>";
			$mail->AltBody = "Senha requisitada $body";
			if ($mail->send()) {
				return true;
			}

			return false;
		} catch (Exception $e) {
			echo $e;
		}
	}
}

 ?>