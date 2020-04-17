<?php

namespace app\Models;

use app\Core\Connection;
use \PDO;

class Auth {

    private PDO $conn;
    private int $id;

    public function __construct() {
        $this->conn = Connection::connect();
    }

    public function isLogged() : bool {

        if (!empty($_SESSION['client_token'])) {
            $token = $_SESSION['client_token'];

            try {
                $query = "SELECT id FROM client WHERE token = :token";
                $stmt = $this->conn->prepare($query);
                $stmt->bindValue(":token", $token, PDO::PARAM_STR);
                $stmt->execute();

                if ($stmt->rowCount() > 0) {
                    return true;
                }
            } catch (PDOException $e) {
                echo "Error: " . $e->getMessage();
                die;
            }
        }

        return false;
    }

    public function validateAuth(string $cpf, string $pass) : bool {

        try {
            $query = "SELECT id FROM client WHERE cpf = :cpf AND pass = :pass";
            $stmt = $this->conn->prepare($query);
            $stmt->bindValue(":cpf", $cpf, PDO::PARAM_STR);
            $stmt->bindValue(":pass", md5($pass), PDO::PARAM_STR);
            $stmt->execute();

            if ($stmt->rowCount() > 0) {
                $id = $stmt->fetch(PDO::FETCH_ASSOC)['id'];
                $stmt->closeCursor();

                if ($this->setToken($id)):
                    return true;
                endif;
            }
        } catch (PDOException $e) {
            die("Error: " . $e->getMessage());
        }

        return false;
    }

    public function setToken(int $id) : bool {
        try {

            $token = md5(time() . rand(0, 99999) . $id);

            $query = "UPDATE client SET token = :token WHERE id = :id";
            $stmt = $this->conn->prepare($query);
            $stmt->bindValue(":token", $token, PDO::PARAM_STR);
            $stmt->bindValue(":id", $id, PDO::PARAM_INT);

            if ($stmt->execute()):
                $stmt->closeCursor();
                $_SESSION['client_token'] = $token;
                return true;
            endif;
        } catch (PDOException $e) {
            die("Error: " . $e->getMessage());
        }

        return false;
    }

}