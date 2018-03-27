<?php

use \Service\DBService as DBService;

class TagModel
{
    public static function saveTags($tags)
    {
        $tagsArray = explode(',',trim($tags));

        foreach($tagsArray as $tag) {
            $query = "SELECT COUNT(id) as countRows FROM `tags` ";
            $query .= " WHERE `tag` like '%" . trim($tag) . "%'";

            $result = \Service\DBService::getInstance()->query($query)->fetch_assoc();
            $tagExist = $result ? (int)$result['countRows'] : false;
            self::addTag($tag, $tagExist);
        }
    }

    private function addTag($tag, $tagExist)
    {
        if (!$tagExist) {
            $query = "INSERT INTO `tags` SET `tag` = '{$tag}'";
            $db = \Service\DBService::getInstance();
            $db->query($query);
        }
    }

    public static function getList()
    {
        $query = "SELECT * FROM `tags`";

        return \Service\DBService::getInstance()->query($query)->fetch_all(MYSQLI_ASSOC);
    }
}
