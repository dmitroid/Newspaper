<?php

class ItemController extends ParentController
{
    public function show()
    {
        global $smarty, $params;

        ItemModel::UpdateShowsItem($params[0]);

        $item = ItemModel::getItem($params[0]);
        $userId = isset($_SESSION['user']) && isset($_SESSION['user']['id']) ? $_SESSION['user']['id'] : 0;

        if ($item[0]['analytic'] && !$userId ) {

            $haystack = $item[0]['description'];
            $needle = '.';
            $pos1 = strpos($haystack, $needle);
            $pos2 = strpos($haystack, $needle, $pos1 + strlen($needle));
            $pos3 = strpos($haystack, $needle, $pos2 + strlen($needle));
            $pos4 = strpos($haystack, $needle, $pos3 + strlen($needle));
            $pos5 = strpos($haystack, $needle, $pos4 + strlen($needle));

            $item[0]['description'] = substr($item[0]['description'], 0, $pos5 + 1);
        }

        $tags = explode(",", $item[0]['tag']);
        $trimmedTags = [];
        foreach($tags as $tag) {
            $trimmedTags[] = trim($tag);
        }
    
        $smarty->assign('page', 'item');
        $smarty->assign('category_name', CategoryModel::getCategoryById($item[0]['category_id']));
        $smarty->assign('articletags', $trimmedTags);
        $smarty->assign('user_id', $userId);
        $smarty->assign('comments', CommentsModel::getParentListByItemId($params[0]));
        $smarty->assign('categories', CategoryModel::getList());
        $smarty->assign('item', $item);
        $smarty->assign('category_id', $item[0]['category_id']);
        $smarty->display('item.tpl');
    }

    public function  currentview()
    {
        global $params;

        $itemId = $params[0];
        $cuurentViews = rand(1,10);
        ItemModel::updateShowsItemCurrent($itemId, $cuurentViews);

        header('Content-Type: application/json');
        $result = json_encode(array('views' => $cuurentViews));

        echo $result;
    }
}
