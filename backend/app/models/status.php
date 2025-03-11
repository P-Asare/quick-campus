<?php

    require_once __DIR__ . '/model.php';

    // Class to represent the statuses
    class Status extends Model {

        protected $table = 'status';

        public function getStatusById($status_id){

            $sql = "SELECT status_name FROM {$this->table} WHERE status_id = :id";

            $stmt = $this->pdo->prepare($sql);
            $stmt->execute(['id' => $status_id]);

            return $stmt->fetch(PDO::FETCH_ASSOC);
        }
    }

?>