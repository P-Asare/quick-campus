<?php

    header('Access-Control-Allow-Methods: GET, PUT, POST, DELETE, PATCH, OPTIONS');
    header('Access-Control-Max-Age: 1000');
    header('Access-Control-Allow-Headers: Content-Type, Authorization, X-Requested-With');
    header('content-Type: application/json');

    require_once __DIR__ . '/vendor/autoload.php';
    require_once __DIR__ . '/config/database.php';
    require_once __DIR__ . '/app/middleware/validationMiddleWare.php';
    require_once __DIR__ . '/app/controllers/userController.php';
    require_once __DIR__ . '/app/controllers/requestController.php';

    use Dotenv\Dotenv;

    $dotenv = Dotenv::createImmutable(__DIR__);
    $dotenv->load();

    $router = new AltoRouter();
    $router->setBasePath('/quick-campus/backend');

    // create database and pdo
    $database = new Database();
    $pdo = $database->getPdo();

    $userController = new UserController($pdo);
    $requestController = new RequestController($pdo);

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
            'role' => 'integer',
            'phone_number' => 'phone_number'
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

    // Get a specific user (For getting the details of a rider)
    $router->map('GET', '/users/[i:user_id]', function ($user_id) use ($userController) {

        ValidationMiddleWare::handle(
            ["user_id" => $user_id],
            ["user_id" => "integer"]
        );

        echo json_encode($userController->getUserById($user_id));
    });

    // Catering for uploading the photo of a user
    $router->map('POST', '/upload/[*:user_id]', function ($user_id) use ($userController) {

        $file = $_FILES['profile_image'];

        ValidationMiddleWare::handle(["user_id" => $user_id], ["user_id" => "integer"]);
        ValidationMiddleWare::handleImage($file);

        echo json_encode($userController->uploadProfileImage($user_id));
    });

    // Catering for user updates
    $router->map('POST', '/users/update/[*:user_id]', function ($user_id) use ($userController){

        $data = json_decode(file_get_contents('php://input'), true);

        ValidationMiddleWare::handle(
            ["user_id" => $user_id],
            ["user_id" =>"integer"]
        );

        ValidationMiddleWare::handle($data, [
            "firstname" => "string",
            "lastname" => "string",
            "phone_number" => "phone_number"
        ]
        );

        echo json_encode($userController->updateProfile($user_id, $data));
    });

    // Place a pending delivery request
    $router->map('POST', '/requests', function () use ($requestController){

        $data = json_decode(file_get_contents('php://input'), true);
        
        ValidationMiddleWare::handle($data, [
            'student_id' => 'integer',
            'dropoff_latitude' => 'decimal',
            'dropoff_longitude' => 'decimal',
        ]);

        echo json_encode($requestController->placePendingRequest($data));
    });

    // Confirm request: Rider endpoint to take up a request
    $router->map('POST', '/confirm_requests', function () use ($requestController) {
        $data = json_decode(file_get_contents('php://input'), true);

        ValidationMiddleWare::handle($data, [
            'pending_id' => 'integer',
            'rider_id' => 'integer',
        ]);

        echo json_encode($requestController->placeRequest($data));
    });

    // Get the pending requests of a student
    // get delivery requests by a user Id for both riders and students
    $router->map('GET', '/pending_requests/[i:user_id]', function ($user_id) use ($requestController){

        ValidationMiddleWare::handle(
            ["user_id" => $user_id], 
            [
                "user_id" => "integer",
            ]
        );

        echo json_encode($requestController->getPendingRequestsByUser($user_id));
    });

    // get delivery requests by a user Id for both riders and students
    $router->map('GET', '/requests/[i:user_role]/[i:user_id]', function ($user_role, $user_id) use ($requestController){

        ValidationMiddleWare::handle(
            ["user_id" => $user_id, "user_role" => $user_role], 
            [
                "user_id" => "integer",
                "user_role" => "integer"
            ]
        );

        if ($user_role == 2){
            echo json_encode($requestController->getRequestsByUser("student_id", $user_id));
        } else if ($user_role == 3) {
            echo json_encode($requestController->getRequestsByUser("rider_id", $user_id));
        }
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