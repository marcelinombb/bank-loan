<?php

if (session_status() === PHP_SESSION_NONE) {
    session_start();
} elseif (session_status() === PHP_SESSION_DISABLED) {
    echo "Error: Verifique as configurações de sessão";
}

require_once "app/config/config.inc.php";
//require_once "libs/vendor/autoload.php";
require_once "../bank-loan/my_autoload.php";

$core = new app\Core\Core();
$core->run();