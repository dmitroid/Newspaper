<?php

class CommentsController extends ParentController
{
    const POLITICS_CATEGORY_ID = 1;

    public function show()
    {
        global $smarty, $params;
        $cat_id = ItemModel::getItem($params[0]);
        $smarty->assign('categories', CategoryModel::getList());
        $smarty->assign('item', ItemModel::getItem($params[0]));
        $smarty->assign('category_id', $cat_id[0]['category_id']);
        $smarty->display('item.tpl');
    }
    
    public function create()
    {
        $item = new CommentsModel(
            $_POST['item_id'],
            $_POST['user_name'],
            $_POST['user_id'],
            $_POST['rating'],
            strip_tags($_POST['comment']),
            $_POST['parent_id']
        );


        $newsItem = ItemModel::getItemById($_POST['item_id'])->toArray();
        if ($newsItem['category_id'] == self::POLITICS_CATEGORY_ID) {
            $item->setModeration(0);
        }

        $item->save();
        
        header("Location: /item/show/" . $_POST['item_id']);
    }
}
