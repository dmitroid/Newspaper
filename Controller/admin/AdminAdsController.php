<?php

class AdminAdsController
{

    public function index()
    {
        global $smarty;
        $smarty->assign('ads', AdsModel::getList());
        $smarty->assign('page', 'ads');
        $smarty->display("admin_ads.tpl");
    }

    public function update()
    {
        $id = (int) $_POST['id'];
        if(!$id) {
            header("Location: /admin");
            exit;
        }
        $ads = AdsModel::findById($id);
        if(!$ads) {
            header("Location: /admin");
            exit;
        }
        $ads->setName($_POST['name']);
        $ads->setPrice($_POST['price']);
        $ads->setFirm($_POST['firm']);
        $ads->setModeration($_POST['moderation']);
        $ads->setWeight($_POST['weight']);
        $ads->save();
        header("Location: /admin/ads");
    }
    
}
