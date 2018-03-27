<?php

use \Service\DBService as DBService;

class ItemModel
{
    const DEFAULT_FILE = "";
    const STORAGE_DIR = 'storage/items/';
    private $id;
    private $name;
    private $description;
    private $tag;
    private $categoryId;
    private $shows;

    public function __construct($name, $description, $tag, $categoryId, $id = null)
    {
        $this->name = $name;
        $this->description = $description;
        $this->tag = $tag;
        $this->categoryId = $categoryId;
        $this->id = $id;
    }

    public function setName($name) {
        $this->name = $name;
    }

    public function setDescription($description) {
        $this->description = $description;
    }

    public function setTag($tag) {
        $this->tag = $tag;
    }

    public function setCategory($id)
    {
        if(!CategoryModel::findById($id))
        {
            throw new Exception("Category not found exception");
        }
        $this->categoryId = $id;
    }
    
    public function setShows($shows) {
        $this->shows = $shows;
    }

    public function setAnalytic($analytic) {
        $this->analytic = $analytic;
    }

    public static function getItemById($id)
{
    if(!($id = (int) $id)) {
        throw new Exception("Error while tried to get the item by id");
    }
    $query = "SELECT * FROM `items` WHERE `id` = '$id'";
    $item = DBService::getInstance()->query($query)->fetch_assoc();
    if (!$item) {
        return null;
    } else {
        $result = new self($item['name'], $item['description'], $item['tag'], $item['category_id'], $item['id']);
        $result->setShows($item['shows']);
        $result->setAnalytic($item['analytic']);
        return $result;
    }

}

    public static function UpdateShowsItem($id)
    {
        $query = "UPDATE `items` SET `shows` = `shows` +1 WHERE `id` = $id";
        $db = \Service\DBService::getInstance();
        $db->query($query);
    }

    public static function updateShowsItemCurrent($id, $cuurentViews)
    {
        $query = "UPDATE `items` SET `shows` = `shows` + {$cuurentViews} WHERE `id` = $id";
        $db = \Service\DBService::getInstance();
        $db->query($query);
    }

    public function save()
    {
    	return $this->id ? $this->update() : $this->create();
    }

    private function update()
    {
	    $query = "UPDATE `items` SET
        `name` = '{$this->name}',
        `description` = '{$this->description}',
        `tag` = '{$this->tag}',
        `category_id` = '{$this->categoryId}',
        `analytic` = '{$this->analytic}'
        WHERE `id` = '{$this->id}'";
	    $db = DBService::getInstance();
	    $db->query($query);
        TagModel::saveTags($this->tag);

	    return $db->insert_id;
    }

    private function create() : bool
    {
        $date = date("Y-m-d H:i:s");
    	$query = "INSERT INTO `items`
        SET
        `name` = '{$this->name}',
        `description` = '{$this->description}',
        `tag` = '{$this->tag}',
        `category_id` = '{$this->categoryId}',
        `news_date` = '{$date}',
        `shows` = 0,
        `analytic` = '{$this->analytic}'
        ";
    	$db = \Service\DBService::getInstance();
    	$db->query($query);
        $this->id = $db->insert_id;
        TagModel::saveTags($this->tag);

	    return (bool) $this->id;
    }

    public function toArray()
    {
    	return [
    		    'name' => $this->name,
		        'description' =>$this->description,
                'tag' => $this->tag,
                'category_id' => $this->categoryId,
                'id' => $this->id,
                'shows' => $this->shows,
                'analytic' => $this->analytic
		    ];
    }

    public static function getList($catId = null, $order = "DESC", $lim = null)
    {
        $query = "SELECT * FROM `items` ";
        if ($catId) {
            $query .= " WHERE `category_id` = $catId ";
        }
        $query .= " ORDER BY `id` $order";
        if ($lim) {
            $query .= " LIMIT $lim";
        }
        
        return \Service\DBService::getInstance()->query($query)->fetch_all(MYSQLI_ASSOC);
    }

    public static function getListCount($catId = null)
    {
        $query = "SELECT COUNT(id) as countRows FROM `items` ";
        if ($catId) {
            $query .= " WHERE `category_id` = $catId ";
        }

        $result = \Service\DBService::getInstance()->query($query)->fetch_assoc();
        return !$result ? null : (int)$result['countRows'];
    }

    public static function getListAnalytic($order = "DESC", $lim = null)
    {
        $query = "SELECT * FROM `items` ";
        $query .= " WHERE `analytic` = 1 ";
        $query .= " ORDER BY `id` $order";
        if ($lim) {
            $query .= " LIMIT $lim";
        }

        return \Service\DBService::getInstance()->query($query)->fetch_all(MYSQLI_ASSOC);
    }

    public static function getListAnalyticCount()
    {
        $query = "SELECT COUNT(id) as countRows FROM `items` ";
        $query .= " WHERE `analytic` = 1 ";

        $result = \Service\DBService::getInstance()->query($query)->fetch_assoc();
        return !$result ? null : (int)$result['countRows'];
    }

    public static function getSearchList($getParams, $order = "DESC", $lim = null)
    {
        $query = "SELECT * FROM `items` ";
        $query .= self::getSearchParams($getParams);

        return \Service\DBService::getInstance()->query($query)->fetch_all(MYSQLI_ASSOC);
    }

    public static function getSearchListCount($getParams)
    {
        $query = "SELECT COUNT(id) as countRows FROM `items` ";
        $query .= self::getSearchParams($getParams);

        $result = \Service\DBService::getInstance()->query($query)->fetch_assoc();
        return !$result ? null : (int)$result['countRows'];
    }

    public static function getSearchParams($getParams)
    {
        $query = '';
        if(!isset($getParams['tags'])) {
            $query .= " WHERE (`name` LIKE '%" . $getParams['term'] . "%' OR `tag` LIKE '%" . $getParams['term'] . "%')";
        } else {
            $query .= " WHERE `name` LIKE '%" . $getParams['term'] . "%'";
        }

        if (isset($getParams['category_ids'])) {
            if (count($getParams['category_ids']) > 1) {
                $query .= " AND (";
            }
            $i = 0;
            foreach($getParams['category_ids'] as $cat_id) {
                if (count($getParams['category_ids']) > 1 && $i) {
                    $query .= " OR ";
                } else if(count($getParams['category_ids']) == 1 ) {
                    $query .= " AND ";
                }
                $query .= " `category_id` = $cat_id";
                $i++;
            }
            if (count($getParams['category_ids']) > 1) {
                $query .= ")";
            }
        }

        if (isset($getParams['tags'])) {
            if (count($getParams['tags']) > 1) {
                $query .= " AND (";
            }
            $i = 0;
            foreach($getParams['tags'] as $tag) {
                if (count($getParams['tags']) > 1 && $i) {
                    $query .= " OR ";
                } else if(count($getParams['tags']) == 1 ) {
                    $query .= " AND ";
                }
                $query .= " `tag` LIKE '%" . $tag . "%'";
                $i++;
            }
            if (count($getParams['tags']) > 1) {
                $query .= ")";
            }
        }

        if (isset($getParams['date_start'])) {
            $query .= " AND `news_date` >= '" . $getParams['date_start'] . "'";
        }

        if (isset($getParams['date_end'])) {
            $query .= " AND `news_date` <= '" . $getParams['date_end'] . "'";
        }

        return $query;
    }


    public static function getLastFour($catId = null, $order = "DESC")
    {
        $query = "SELECT * FROM `items` ";
        if ($catId) {
            $query .= " WHERE `category_id` = $catId ";
        }
        $query .= " ORDER BY `id` $order LIMIT 4";
        return \Service\DBService::getInstance()->query($query)->fetch_all(MYSQLI_ASSOC);
    }

    public function remove()
    {
        if (!$this->id) {
            throw new Exception ("Invalid id");
        }
        \Service\DBService::getInstance()->query("DELETE FROM `items` WHERE `id` = {$this->id}");
    }

    public function getId()
    {
        return $this->id;
    }

    public static function getItemsByIds(array $ids)
    {
        if(!$ids) {
            return [];
        }

        $query = "SELECT * FROM `items` WHERE `id` IN (".implode(",", $ids).")";
        return \Service\DBService::getInstance()->query($query)->fetch_all(MYSQLI_ASSOC);
    }
    
    public static function getItem($id)
    {
        $query = "SELECT * FROM `items` WHERE `id` = $id";
        return \Service\DBService::getInstance()->query($query)->fetch_all(MYSQLI_ASSOC);
    }
}
