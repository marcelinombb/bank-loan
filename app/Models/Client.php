<?php

namespace app\Models;

class Client {
    private int $id;
    private string $name;
    private string $surname;
    private string $cpf;
    private string $email;
    private string $pass;
    private float $ordenado;
    private int $active;

    public function setId(int $id) : void {
        $this->id = trim($id);
    }

    public function getId() : int {
        return $this->id;
    }

    public function setName(string $name) : void {
        $this->name = ucwords(trim($name));
    }

    public function getName() : string {
        return $this->name;
    }

    public function setSurname(string $surname) : void {
        $this->surname = ucwords(trim($surname));
    }

    public function getSurname() : string {
        return $this->surname;
    }

    public function setCpf(string $cpf) : void {
        $this->cpf = trim($cpf);
    }

    public function getCpf() : string {
        return $this->cpf;
    }

    public function setEmail(string $email) : void {
        $this->email = strtolower(trim($email));
    }

    public function getEmail() : string {
        return $this->email;
    }

    public function setPass(string $pass) : void {
        $this->pass = preg_match('/^[a-f0-9]{32}$/', $pass) ? $pass : md5(trim($pass));
    }

    public function getPass() : string {
        return $this->pass;
    }

    public function setOrdenado(float $ordenado) : void {
        $this->ordenado = trim($ordenado);
    }

    public function getOrdenado() : float {
        return $this->ordenado;
    }

    public function setActive(int $active) : void {
        $this->active = trim($active);
    }

    public function getActive() : int {
        return $this->active;
    }
}