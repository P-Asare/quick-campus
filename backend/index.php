<?php

    require_once __DIR__ . '/vendor/autoload.php';
    require_once __DIR__ . '/config/database.php';

    use Dotenv\Dotenv;

    $dotenv = Dotenv::createImmutable(__DIR__);
    $dotenv->load();

    // create database and pdo
    $database = new Database();
    $pdo = $database->getPdo();

    echo "Working";
    
?>