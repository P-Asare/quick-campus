<?php
require_once __DIR__ . '/model.php';

/// Class to represent the Users database
class User extends Model
{
    protected $table = 'users';

    // Create single user
    public function createUser($firstname, $lastname, $email, $password, $role, $phonenumber)
    {
        $password_hash = password_hash($password, PASSWORD_DEFAULT);
        
        $data = [
            'firstName' => $firstname,
            'lastName' => $lastname,
            'email' => $email,
            'password' => $password_hash,
            'role_id' => $role,
            'phone_number' => $phonenumber,
        ];

        return $this->insert($data);
    }

    // Find a user by their email address
    public function findByEmail($email)
    {
        $result = $this->find("email", $email);
        return $result;
    }

    // Fetch all the users in the system with a specific set of column details
    public function fetchAll()
    {
        $sql = "SELECT user_id, firstName, lastName, email, profile_image
                FROM {$this->table}";

        $stmt = $this->pdo->query($sql);
        return $stmt->fetchAll(PDO::FETCH_ASSOC);
    }

    // Fetch all drivers in the system with a specific set of column details (attributes)
    public function fetchAllDrivers()
    {
        $sql = "SELECT user_id, firstName, lastName, email, phone_number, profile_image
                FROM {$this->table} WHERE role_id = 3";

        $stmt = $this->pdo->query($sql);
        return $stmt->fetchAll(PDO::FETCH_ASSOC);
    }

    // Find a user by their id
    public function findProfileById($id)
    {
        $sql = "SELECT user_id, firstname, lastname, email, phone_number, role_id, profile_image FROM " . $this->table . " WHERE user_id = :id";
        $stmt = $this->pdo->prepare($sql);
        $stmt->execute(['id' => $id]);
        return $stmt->fetch(PDO::FETCH_ASSOC);
    }

    // Update user profile image
    public function updateProfileImage($id, $imagePath){
        $sql = "UPDATE {$this->table} SET profile_image = :profile_image WHERE user_id = :id";
        $stmt = $this->pdo->prepare($sql);
        return $stmt->execute(['profile_image' => $imagePath, 'id' => $id]);
    }

    // Update user details
    public function updateProfile($id, $data){
        return $this->update($id, $data);
    }

    // update password
    public function resetPassword($email, $newPassword)
    {
        $password_hash = password_hash($newPassword, PASSWORD_DEFAULT);
        $sql = "UPDATE {$this->table} SET password = :password WHERE email = :email";
        $stmt = $this->pdo->prepare($sql);
        return $stmt->execute(['password' => $password_hash, 'email' => $email]);
    }

}
?>
