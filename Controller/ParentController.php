<?php

class ParentController
{
    public function __construct()
    {
        global $smarty;

        $tags = TagModel::getList();
        $smarty->assign('tags', $tags);

        $ads_left = AdsModel::getList(1);
        $smarty->assign('ads_left', $ads_left);

        $ads_right = AdsModel::getList(2);
        $smarty->assign('ads_right', $ads_right);
        
        $smarty->assign('cl', ThemeModel::getList());
        
        $smarty->assign('topcommentators', CommentsModel::getListTopUsers());
        $smarty->assign('topitem', CommentsModel::getListTopItemComments());
        
        $smarty->assign('categories', CategoryModel::getList());
        
        $smarty->assign('banner', ItemModel::getLastFour());
    }
}
