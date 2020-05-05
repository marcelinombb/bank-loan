<?php declare(strict_types=1);

namespace app\Models;

use app\Core\Connection;
use \PDO;
use \PDOException;

class Auth {
    private int $id;
    private string $token;
    private ?PDO $conn;

    public function __construct() {
        $this->conn = Connection::connect();
    }

    public function validateAuth(Client $client) : bool {

        try {
            $query = "SELECT id FROM client WHERE cpf = :cpf AND pass = :pass";
            $stmt = $this->conn->prepare($query);
            $stmt->bindValue(":cpf", $client->getCpf(), PDO::PARAM_STR);
            $stmt->bindValue(":pass", $client->getPass(), PDO::PARAM_STR);
            $stmt->execute();

            if ($stmt->rowCount() > 0) {
                $this->id = intval($stmt->fetch(PDO::FETCH_OBJ)->id);
                $stmt->closeCursor();

                if ($this->setToken($this->id)):
                    return true;
                endif;
                
                return false;
            }
        } catch (PDOException $e) {
            die("Error: " . $e->getMessage());
        }

        return false;
    }

    public function setToken(int $id) : bool {
        try {

            $this->token = md5(time() . rand(0, 99999) . $id);

            $query = "UPDATE client SET token = :token WHERE id = :id";
            $stmt = $this->conn->prepare($query);
            $stmt->bindValue(":token", $this->token, PDO::PARAM_STR);
            $stmt->bindValue(":id", $id, PDO::PARAM_INT);

            if ($stmt->execute()):
                $stmt->closeCursor();
                return true;
            endif;
        } catch (PDOException $e) {
            die("Error: " . $e->getMessage());
        }

        return false;
    }
    
    public function getId() : int {
        return $this->id;
    }
    
    public function getToken() : string {
        return $this->token;
    }

}