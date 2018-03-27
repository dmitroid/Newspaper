<?php

class AdminAddController
{

    public function index()
    {
        global $smarty;
        $smarty->assign('categories', CategoryModel::getListAll());
        $smarty->assign('page', 'add');
        $smarty->display("admin_add.tpl");
    }

    public function create()
    {
        $item = new ItemModel(
            $_POST['name'],
            $_POST['description'],
            $_POST['tag'],
            $_POST['category_id']
        );

        $item->setAnalytic(isset($_POST['analytic']) ? 1 : 0 );

        $item->save();

        if (isset($_FILES['file'])) {
            move_uploaded_file($_FILES['file']['tmp_name'], ItemModel::STORAGE_DIR.$item->getId().".jpg");
        }

        header("Location: /admin/items");
    }

}
