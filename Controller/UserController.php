<?php


class UserController extends ParentController
{
    public function index()
    {
    }
    
    public function comments()
    {
        global $smarty, $params;

        $pagination = $this->getPageData($params[0]);
        
        $smarty->assign('categories', CategoryModel::getList());
        $smarty->assign('comments', CommentsModel::getListByUserId($params[0], 'DESC', $this->getLim($pagination)));
        $smarty->assign('user_id', $params[0]);
        $smarty->assign('pagination', $pagination);
        $smarty->assign('category_id', 0);
        $smarty->assign('page', 'comments');
        $smarty->display('comments.tpl');
    }

    private function getPageData($userId)
    {
        global $params;

        $pagination = [];
        $pagination['count'] = CommentsModel::getListCount($userId);
        $pagination['currentPage'] = isset($params[1]) ? $params[1] : 1;
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
