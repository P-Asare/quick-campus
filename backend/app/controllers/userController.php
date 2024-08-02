<?php

require_once __DIR__ . '/../models/user.php';
// Class to cater for all user oriented actions
class UserController
{
    protected $userModel;

    public function __construct($pdo)
    {
        $this->userModel = new User($pdo);
    }

    // Hand create user action using the user model
    public function createUser($data)
    {

        try {

            $this->userModel->createUser(
                $data['firstname'],
                $data['lastname'],
                $data['email'],
                $data['password'],
                $data['role'],
                $data['phone_number']
            );

            return ['success' => true];
        } catch (PDOException $pe) {
            if ($pe->getCode() == 23000) {
                header('HTTP/1.1 422 Unprocessable Entity');
                $errors = ["success" => false, "error" => "Email already exists in system"];
                return $errors;
            }
        } catch (\Exception $e) {
            header('HTTP/1.1 422 Unprocessable Entity');
            $errors = ["success" => false, "error" => $e->getMessage()];
            return $errors;
        }
    }

    // Handle user login action using the user model
    public function login($data)
    {
        try {

            $db_details = $this->userModel->findByEmail($data['email']);

            if ($db_details == false) { // throw exception if email is wrong
                throw new InvalidArgumentException("Wrong email.");
            }

            $login_password = $data['password'];
            $db_password = $db_details['password'];

            if (password_verify($login_password, $db_password)) { // throw exception if password is wrong

                return [
                    "success" => true, 
                    "id" => $db_details['user_id'],
                    "firstname" => $db_details['firstname'],
                    "lastname" => $db_details['lastname'],
                    "email" => $db_details['email'],
                    "phone_number" => $db_details["phone_number"],
                    "profile_image" => $db_details["profile_image"],
                    "role" => $db_details['role_id']
                ];
            } else {
                throw new InvalidArgumentException("Wrong password.");
            }
        } catch (InvalidArgumentException $e) { // Handle wrong password and email from user
            header('HTTP/1.1 422 Unprocessable Entity');
            return [
                "success" => false,
                "error" => $e->getMessage()
            ];
        } catch (Exception $e) {
            header('HTTP/1.1 422 Unprocessable Entity');
            return [
                "success" => false,
                "error" => $e->getMessage(),
            ];
        }
    }

    // Handle request to fetch all users
    public function getAll(){
        try {

            // get all the users in the database
            $users = $this->userModel->fetchAll();

            return ["success" => true, "data" => $users];
        } catch (\Exception $e) {
            header('HTTP/1.1 422 Unprocessable Entity');
            return [
                "success" => false,
                "error" => $e->getMessage(),
            ];
        }
    }

    // Handle request to fetch all drivers
    public function getAllDrivers()
    {

        try {

            // get all the users in the database
            $users = $this->userModel->fetchAllDrivers();

            return ["success" => true, "data" => $users];
        } catch (\Exception $e) {
            header('HTTP/1.1 422 Unprocessable Entity');
            return [
                "success" => false,
                "error" => $e->getMessage(),
            ];
        }
    }

    public function getUserById($userId)
    {
        try {
            $result = $this->userModel->findProfileById($userId);
            if ($result) {
                return ["success" => true, "data" => $result];
            } else {
                header('HTTP/1.1 404 Not Found');
                return ["success" => false, "error" => "User not found"];
            }
        } catch (Exception $e) {
            header('HTTP/1.1 422 Unprocessable Entity');
            return ["success" => false, "error" => $e->getMessage()];
        }
    }

    // Update profile based on id
    public function updateProfile($id, $data){
        $response = $this->userModel->updateProfile($id, $data);
        return ["success" => true];
    }

    // upload user profile
    public function uploadProfileImage($id){

        try {
            
            if(!isset($_FILES['profile_image'])){
                throw new InvalidArgumentException("No image attached");
            }

            $file = $_FILES['profile_image'];
            $dir = __DIR__ . '/../../public/profile_images/';
            $targetFile = $dir . basename($file['name']) . '-' . $id;

            // move file from temp position to directory intenteded
            if(!move_uploaded_file($file['tmp_name'], $targetFile)){
                header('HTTP/1.1 500 Server Error');
                throw new Exception("Error moving image");
            }

            // update user profile image path in database
            $this->userModel->updateProfileImage($id, basename($targetFile));

            return ["success" => true, "message" => "Successful profile upload"];

        } catch (InvalidArgumentException $e) {
            
            header('HTTP/1.1 422 Unprocessable Entity');
            return ["success" => false, "message" => "File was not found in payload"];

        } catch (Exception $e){

            return ["success" => false, "message" => $e->getMessage()];

        }
    }



}