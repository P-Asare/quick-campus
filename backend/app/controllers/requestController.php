<?php

    require_once __DIR__ . '/../models/request.php';
    require_once __DIR__ . '/../models/pending_requests.php';
    require_once __DIR__ . '/../models/status.php';

    /// Class to cater for all request oriented actions
    class RequestController{

        protected $requestModel;
        protected $pendingRequestModel;
        protected $statusModel;

        public function __construct($pdo){
            $this->requestModel = new Request($pdo);
            $this->pendingRequestModel = new PendingRequest($pdo);
            $this->statusModel = new Status($pdo);
        }
        
        // create a delivery request
        public function placePendingRequest($data){

            try {
                $pending_id = $this->pendingRequestModel->createRequest($data);

                return [
                    'success' => true,
                    'pending_id' => $pending_id
                ];
            } catch (\Exception $e) {
                header('HTTP/1.1 422 Unprocessable Entity');
                $errors = ["success" => false, "error" => $e->getMessage()];
                return $errors;
            }      
        }

        // Move request from pending to being delivered
        public function placeRequest($data){

            try {
                $pending_data = $this->pendingRequestModel->findRequestById($data['pending_id']);

                // add rider id
                $new_data = [
                    'student_id' => $pending_data['student_id'],
                    'dropoff_latitude' => $pending_data['dropoff_latitude'],
                    'dropoff_longitude' => $pending_data['dropoff_longitude'],
                    'rider_id' => $data['rider_id'],
                ];
                
                $this->pendingRequestModel->deletePendingRequest($data['pending_id']);
                $request_id = $this->requestModel->createRequest($new_data);
                $response_data = $this->requestModel->findRequestById($request_id);
                $response_data['status'] = $this->statusModel->getStatusById($response_data['status'])["status_name"];

                return [
                    'success' => true,
                    'data' => $response_data
                ];
            } catch (\Exception $e) {
                header('HTTP/1.1 422 Unprocessable Entity');
                $errors = ["success" => false, "error" => $e->getMessage()];
                return $errors;
            }      
        }

        // get pending requests by students
        public function getPendingRequestsByUser($user_id){

            try {

                $pendingRequests = $this->pendingRequestModel->findRequestsByUser($user_id);
                return ['success' => true, 'data' => $pendingRequests];

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
                $requests[0]['status'] = $this->statusModel->getStatusById($requests[0]['status'])["status_name"];
                return ['success' => true, 'data' => $requests];

            } catch (\Exception $e) {
                header('HTTP/1.1 422 Unprocessable Entity');
                $errors = ["success" => false, "error" => $e->getMessage()];
                return $errors;
            }
        }

        // Get all pending requests
        public function getAllPendingRequests(){
            
            try {
                
                $pending_requests = $this->pendingRequestModel->fetchAllPendingRequests();
                return ['success' => true, 'data' => $pending_requests];

            } catch (\Exception $e) {
                
                header('HTTP/1.1 422 Unprocessable Entity');
                $errors = ["success" => false, "error" => $e->getMessage()];
                return $errors;
            }
        }


    }
?>