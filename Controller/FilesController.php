<?php

class FilesController extends ParentController
{
    public function show()
    {
        global $params;
        $path = ItemModel::STORAGE_DIR.$params[0].".jpg";
        if (file_exists($path)) {
            header("Content-Type: image/jpg");
            die(file_get_contents($path));
        }
        header("Content-Type: image/png");
        die(file_get_contents(ItemModel::STORAGE_DIR."a.png"));
    }
}
