<?php

class ThemeModel
{
    private $id;
    private $block;
    private $color;
    
    public function __construct($block, $color, $id)
    {
        $this->block = $block;
        $this->color = $color;
        $this->id = $id;
    }

    public static function findById($id)
    {
        $db = \Service\DBService::getInstance();
        $res = $db->query("SELECT * FROM `theme` WHERE `id` = $id LIMIT 1")->fetch_assoc();
        return $res ? new self($res["block"], $res['color'], $res['id']) : null;
    }

    public function getId()
    {
        return $this->id;
    }

    public function getBlock()
    {
        return $this->block;
    }

    public function getColor()
    {
        return $this->color;
    }

    public function save()
    {
        return $this->update();
    }

    public function setBlock($block)
    {
        $this->block = $block;
    }

    public function setColor($color)
    {
        $this->color = $color;
    }

    private function update()
    {
        $query = "UPDATE `theme`
        SET
        `color` = '{$this->color}'
        WHERE `id` = {$this->id}";
        $db = \Service\DBService::getInstance();
        $db->query($query);

        return (bool) $db->affected_rows;
    }

    public static function getList()
    {
        $query = "SELECT * FROM `theme`";
        
        $result = \Service\DBService::getInstance()->query($query)->fetch_all(MYSQLI_ASSOC);
        return $result;

    }
    
}