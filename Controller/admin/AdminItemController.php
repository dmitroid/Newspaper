<?php

class AdminItemController
{

    public function index()
    {

    }
    
    public function show() {
        global $smarty, $params;

        $smarty->assign('items', ItemModel::getItemById($params[0])->toArray());
        $smarty->assign('categories', CategoryModel::getListAll());
        $smarty->assign('page', 'items');
        $smarty->display("admin_item.tpl");
    }

    public function remove()
    {
        global $params;
        $item = ItemModel::getItemById($params[0]);
        if(file_exists(ItemModel::STORAGE_DIR.$item->getId().".jpg")) {
            unlink(ItemModel::STORAGE_DIR.$item->getId().".jpg");
        }
        $item->remove();
        header("Location: /admin/items");
    }

    public function update()
    {

        $id = (int) $_POST['id'];
        if(!$id) {
            header("Location: /admin/items");
            exit;
        }
        $item = ItemModel::getItemById($id);
        $item->setName($_POST['name']);
        $item->setCategory($_POST['category_id']);
        $item->setDescription($_POST['description']);
        $item->setTag($_POST['tag']);
        $item->setAnalytic(isset($_POST['analytic']) ? 1 : 0 );
        $item->save();

        if (isset($_FILES['file'])) {
            move_uploaded_file($_FILES['file']['tmp_name'], ItemModel::STORAGE_DIR.$item->getId().".jpg");
        }

        header("Location: /admin/items");
    }

    public function create()
    {
        $item = new ItemModel(
            $_POST['name'],
            $_POST['description'],
            $_POST['tag'],
            $_POST['category_id']
        );

        $item->save();

        if (isset($_FILES['file'])) {
            move_uploaded_file($_FILES['file']['tmp_name'], ItemModel::STORAGE_DIR.$item->getId().".jpg");
        }

        header("Location: /admin/items");
    }

}
