<?php


class AdminCommentController
{

    public function index()
    {

    }

    public function show() {
        global $smarty, $params;

        $comment = CommentsModel::findById($params[0])->toArray();

        $smarty->assign('item', ItemModel::getItemById($comment['item_id'])->toArray());
        $smarty->assign('comment', $comment);
        $smarty->assign('comment_id', $params[0]);
        $smarty->assign('page', 'comments');
        $smarty->display("admin_comment.tpl");
    }

    public function remove()
    {
        global $params;
        $comment = CommentsModel::findById($params[0]);
        $comment->setId($params[0]);
        $comment->remove();
        header("Location: /admin/items");
    }

    public function update()
    {

        $id = (int) $_POST['id'];
        if(!$id) {
            header("Location: /admin/items");
            exit;
        }

        $comment = CommentsModel::findById($id);
        $comment->setId($id);
        $comment->setComment($_POST['comment']);
        $comment->setModeration(isset($_POST['moderation']) ? 1 : 0);
        $comment->save();

        header("Location: /admin/comments");
    }

    public function create()
    {
        $item = new ItemModel(
            $_POST['name'],
            $_POST['description'],
            $_POST['price'],
            $_POST['category_id'],
            $_POST['count']
        );

        $item->save();

        if (isset($_FILES['file'])) {
            move_uploaded_file($_FILES['file']['tmp_name'], ItemModel::STORAGE_DIR.$item->getId().".jpg");
        }

        header("Location: /admin/items");
    }

}
