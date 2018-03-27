<?php


use \Service\DBService as DBService;
use \Service\SessionService as SessionService;

class UserModel
{

    private $login;
    private $pass;
    private $id;
    private $role;

    public function __construct($login, $pass, $id = null, $role = 0)
    {
        $this->login = $login;
        $this->pass = ($id) ? $pass : md5($pass);
        $this->role = $role;
        $this->id = $id;
    }

    public static function getUserByLogin($login)
    {
        $query = "SELECT * FROM `users` WHERE `login` = '$login' LIMIT 1";
        $user = DBService::getInstance()->query($query)->fetch_assoc();
        return !$user ? null : new self($login, $user['pass'], $user['id'], $user['role']);
    }

    public function getLogin()
    {
        return $this->login;
    }

    public function getPass()
    {
        return $this->pass;
    }

    public function getId()
    {
        return $this->id;
    }

    public function getRole()
    {
        return $this->role;
    }

    public function save()
    {
    	return $this->id ? $this->update() : $this->create();
    }

    private function update()
    {
	    $query = "UPDATE `users` SET `login` = '{$this->login}', `pass` = '{$this->pass}', role = '0' WHERE ";
	    $db = DBService::getInstace();
	    $db->query($query);
	    return $db->insert_id;
    }

    private function create()
    {
	    global $session;
    	$query = "INSERT INTO `users` SET `login` = '{$this->login}', `pass` = '{$this->pass}', role = '0'";
    	$db = DBService::getInstance();
    	$db->query($query);
	    $res = (bool) $db->insert_id;
	    if (!$res) {
	    	return null;
	    }


	    $session->set('user', $this->getUserByLogin($this->login)->toArray());
	    return true;
    }

    public function toArray()
    {
    	return [
    		    'login' => $this->login,
		        'pass' =>$this->pass,
                'id' => $this->id,
                'role' => $this->role
		    ];
    }

}