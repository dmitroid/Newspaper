<?php

class AdminCategoriesController
{

    public function index()
    {
        global $smarty;
        $smarty->assign('categories', CategoryModel::getListAll());
        $smarty->assign('page', 'categories');
        $smarty->display("admin_categories.tpl");
    }

    public function create()
    {
        $category = new CategoryModel($_POST['name'], $_POST['weight'], $_POST['parent_id']);
        $category->save();
        header("Location: /admin");
    }

    public function update()
    {
        $id = (int) $_POST['id'];
        if(!$id) {
            header("Location: /admin");
            exit;
        }
        $category = CategoryModel::findById($id);
        if(!$category) {
            header("Location: /admin");
            exit;
        }
        $category->setName($_POST['name']);
        $category->setWeight($_POST['weight']);
        $category->setParentId($_POST['parent_id']);
        $category->save();
        header("Location: /admin");
    }

    public function remove()
    {
        header("Content-Type: application/json");
        if($_SERVER['REQUEST_METHOD'] !== "DELETE") {
            http_response_code(405);
            die(json_encode([
                'status' => false,
                'message' => "Bad method call"
            ]));
        }
        global $params;
        $category = CategoryModel::findById($params[0]);
        $category->remove();
        die(json_encode([
            'status' => true
        ]));
    }

}
