<?php

class AdsModel
{
    private $id;
    private $name;
    private $price;
    private $firm;
    private $moderation;
    private $weight;

    public function __construct($name, $price, $firm, $moderation, $weight, $id)
    {
        $this->name = $name;
        $this->price = $price;
        $this->firm = $firm;
        $this->moderation = $moderation;
        $this->weight = $weight;
        $this->id = $id;
    }

    public static function findById($id)
    {
        $db = \Service\DBService::getInstance();
        $res = $db->query("SELECT * FROM `ads` WHERE `id` = $id LIMIT 1")->fetch_assoc();
        return $res ? new self($res["name"], $res['price'], $res['firm'], $res['moderation'], $res['weight'], $res['id']) : null;
    }

    public function getId()
    {
        return $this->id;
    }

    public function getName()
    {
        return $this->name;
    }

    public function getFirm()
    {
        return $this->firm;
    }
    public function getPrice() {
        return $this->price;
    }
    public function getModeration() {
        return $this->moderation;
    }
    public function getWeight() {
        return $this->weight;
    }

    public function save()
    {
        return $this->update();
    }

    public function setName($name)
    {
        $this->name = $name;
    }

    public function setPrice($price)
    {
        $this->price = $price;
    }
    
    public function setFirm($firm)
    {
        $this->firm = $firm;
    }
    
    public function setModeration($moderation)
    {
        (!$moderation) ? $this->moderation = 0 : $this->moderation = 1;
    }
    public function setWeight($weight)
    {
        $this->weight = $weight;
    }

    private function update()
    {
        $query = "UPDATE `ads`
        SET
        `name` = '{$this->name}',
        `price` = {$this->price},
        `firm` = '{$this->firm}',
        `moderation` = {$this->moderation},
        `weight` = {$this->weight}
            WHERE `id` = {$this->id}";
        $db = \Service\DBService::getInstance();
        $db->query($query);

        return (bool) $db->affected_rows;
    }

    public static function getList($block = null, $order = "DESC")
    {
        $query = "SELECT * FROM ads";
        if ($block == 1) {
            $query .= " WHERE `id` IN (1, 2, 3, 4) AND `moderation` = 1";
        }
        if ($block == 2) {
            $query .= " WHERE `id` IN (5, 6, 7, 8) AND `moderation` = 1";
        }
        $query .= " ORDER BY `weight` $order";
        
        $result = \Service\DBService::getInstance()->query($query)->fetch_all(MYSQLI_ASSOC);
        return $result;

    }
    
}