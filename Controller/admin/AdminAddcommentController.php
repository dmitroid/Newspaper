<?php


class AdminAddcommentController
{

    public function index()
    {
        global $smarty;
        global $params;

        $smarty->assign('item', ItemModel::getItemById($params[0])->toArray());
        $smarty->assign('page', 'comments');
        $smarty->display("admin_add_comment.tpl");
    }

    public function create()
    {
        $session = $_SESSION;

        $item = new CommentsModel(
            $_POST['item_id'],
            $session['user']['login'],
            $session['user']['id'],
            0,
            $_POST['comment'],
            0
        );

        $item->save();

        header("Location: /admin/item/show/".$_POST['item_id']);
    }

}
