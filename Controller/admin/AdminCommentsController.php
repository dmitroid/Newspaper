<?php

class AdminCommentsController
{

    public function index()
    {
        global $smarty;

        $pagination = $this->getPageData();

        $smarty->assign('comments', CommentsModel::getList('DESC', $this->getLim($pagination)));
        $smarty->assign('pagination', $pagination);
        $smarty->assign('page', 'comments');
        $smarty->display("admin_comments.tpl");
    }

    private function getPageData()
    {
        global $params;

        $pagination = [];
        $pagination['count'] = CommentsModel::getListCount();
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

}
