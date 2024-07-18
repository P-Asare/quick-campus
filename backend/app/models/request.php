<?php

    require_once __DIR__ . '/model.php';

    /// Class to represent a delivery/pickup request
    class Request extends Model {

        protected $table = 'requests';

        // Create a request
        public function createRequest($data){

            // put data in table
            $this->insert($data);
            return $this->pdo->lastInsertId();
        }

        // Find request by Id
        public function findRequestById($request_id){

            return $this->find('request_id', $request_id);
        }

        // Fetch all requests for a user
        public function findRequestsByUser($column, $user_id){

            $sql = "SELECT * FROM {$this->table} WHERE $column = :user_id";
            $stmt = $this->pdo->prepare($sql);
            $stmt->execute(['user_id' => $user_id]);
            return $stmt->fetchAll(PDO::FETCH_ASSOC);
        }
    }

?>