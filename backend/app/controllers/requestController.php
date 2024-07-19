<?php

    require_once __DIR__ . '/../models/request.php';

    /// Class to cater for all request oriented actions
    class RequestController{

        protected $requestModel;

        public function __construct($pdo){
            $this->requestModel = new Request($pdo);
        }
        
        // create a delivery request
        public function placeRequest($data){

            try {
                $request_id = $this->requestModel->createRequest($data);

                return [
                    'success' => true,
                    'request_id' => $request_id
                ];
            } catch (\Exception $e) {
                header('HTTP/1.1 422 Unprocessable Entity');
                $errors = ["success" => false, "error" => $e->getMessage()];
                return $errors;
            }      
        }

        // get orders by user
        public function getRequestsByUser($column, $user_id){

            try {
                
                $requests = $this->requestModel->findRequestsByUser($column, $user_id);
                return ['success' => true, 'data' => $requests];

            } catch (\Exception $e) {
                header('HTTP/1.1 422 Unprocessable Entity');
                $errors = ["success" => false, "error" => $e->getMessage()];
                return $errors;
            }
        }


    }
?>