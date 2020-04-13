<?php
function myload($namespace){

    $namespace = str_replace("\\","/", $namespace);
    $classPath = $namespace . ".php";
    
    return include_once $classPath;
}

spl_autoload_register(__NAMESPACE__ . "\myload");
?>