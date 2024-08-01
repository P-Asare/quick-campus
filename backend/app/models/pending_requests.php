<?php

    require_once __DIR__ . '/model.php';

    ///Class to represent pending requests
    class PendingRequest extends Model {

        protected $table = 'pending_requests';

        // Create a request
        public function createRequest($data) {

            // put data in table
            $this->insert($data);
            return $this->pdo->lastInsertId();
        }

        // Find request by Id
        public function findRequestById($request_id){

            return $this->find('pending_id', $request_id);
        }

        // Find pending request by Id
        public function findRequestsByUser($user_id){

            $sql = "SELECT * from {$this->table} WHERE student_id = :user_id";
            $stmt = $this->pdo->prepare($sql);
            $stmt->execute(['user_id' => $user_id]);
            return $stmt->fetchAll(PDO::FETCH_ASSOC);
        }

        // Delete pending request by Id
        public function deletePendingRequest($pending_id){

            return $this->delete('pending_id', $pending_id);
        }

        // Fetch all pending requests
        public function fetchAllPendingRequests(){
            return $this->all();
        }
    }

?>