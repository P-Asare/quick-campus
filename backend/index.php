<?php

    header('Access-Control-Allow-Methods: GET, PUT, POST, DELETE, PATCH, OPTIONS');
    header('Access-Control-Max-Age: 1000');
    header('Access-Control-Allow-Headers: Content-Type, Authorization, X-Requested-With');
    header('content-Type: application/json');

    require_once __DIR__ . '/vendor/autoload.php';
    require_once __DIR__ . '/config/database.php';
    require_once __DIR__ . '/app/middleware/validationMiddleWare.php';
    require_once __DIR__ . '/app/controllers/userController.php';

    use Dotenv\Dotenv;

    $dotenv = Dotenv::createImmutable(__DIR__);
    $dotenv->load();

    $router = new AltoRouter();
    $router->setBasePath('/quick-campus/backend');

    // create database and pdo
    $database = new Database();
    $pdo = $database->getPdo();

    $userController = new UserController($pdo);

    // Routes
    // Below I will define all the different end points clients can interact with

    // cater for user register
    $router->map('POST', '/users', function () use ($userController) {

        $data = json_decode(file_get_contents('php://input'), true);

        // validate data
        ValidationMiddleWare::handle($data, [
            'firstname' => 'string',
            'lastname' => 'string',
            'email' => 'email',
            'password' => 'password',
            'confirm_password' => 'confirm_password',
        ]);

        echo json_encode($userController->createUser($data));
    });

    // Cater for user login
    $router->map('POST', '/users/login', function () use ($userController) {

        $data = json_decode(file_get_contents('php://input'), true);

        // validate data
        ValidationMiddleWare::handle($data, [
            'email' => 'string',
            'password' => 'password',
        ]);

        echo json_encode($userController->login($data));
    });
    
    // Match the request to a defined endpoint
    $match = $router->match();

    if ($match && is_callable($match['target'])) {
        call_user_func_array($match['target'], $match['params']);
    } else {
        // No route was matched
        http_response_code(404);
        echo json_encode(['status' => 'error', 'message' => 'Route not found']);
    }
?>