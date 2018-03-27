<?php

class AdminItemsController
{

    public function index()
    {
        global $smarty;

        $pagination = $this->getPageData();

        $smarty->assign('items', ItemModel::getList(null, 'DESC', $this->getLim($pagination)));
        $smarty->assign('categories', CategoryModel::getListAll());
        $smarty->assign('pagination', $pagination);
        $smarty->assign('page', 'items');
        $smarty->display("admin_items.tpl");
    }

    private function getPageData()
    {
        global $params;

        $pagination = [];
        $pagination['count'] = ItemModel::getListCount();
        $pagination['currentPage'] = isset($params[0]) ? $params[0] : 1;
        $pagination['pagesCount'] = ceil($pagination['count']/5);
        $pagination['next'] = ($pagination['currentPage'] < $pagination['pagesCount']) ? $pagination['currentPage'] + 1 : 0;
        $pagination['prev'] = ($pagination['currentPage'] > 1) ? $pagination['currentPage'] - 1 : 0;

        return $pagination;
    }

    private function getLim($pagination)
    {
        $itemsPerPage = 5;
        $offset = ($pagination['currentPage'] - 1) * $itemsPerPage;

        return $offset . ',' . $itemsPerPage;
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
}
