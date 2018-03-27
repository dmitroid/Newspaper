<?php

class AdminThemeController
{

    public function index()
    {
        global $smarty;

        $smarty->assign('blocks', ThemeModel::getList());
        $smarty->assign('page', 'theme');
        $smarty->display("admin_theme.tpl");
    }

    public function update()
    {
        $id = (int) $_POST['id'];
        if(!$id) {
            header("Location: /admin");
            exit;
        }
        $block = ThemeModel::findById($id);
        if(!$block) {
            header("Location: /admin");
            exit;
        }
        $block->setColor($_POST['color']);
    
        $block->save();
        header("Location: /admin/theme");
    }
    
}
