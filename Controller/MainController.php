<?php

class MainController extends ParentController
{
    public function index()
    {
        global $smarty;

        if(isset($_GET['ref']) && $ref = $_GET['ref']) {
            header("Location: ".$ref);
            exit;
        }

        $categories = CategoryModel::getListAll();
        $arr_news = array();
        foreach ($categories as $cat) {
            $arr_news[] = ItemModel::getList($cat['id'], 'desc', 3);
        }

        $smarty->assign('page', 'main');
        $smarty->assign('news_main', $categories);
        $smarty->assign('items', $arr_news);
        $smarty->assign('banner', ItemModel::getLastFour());
        $smarty->assign('category_id', 0);
        $smarty->display('index.tpl');
    }

    public function show()
    {
        global $smarty, $params;

        $pagination = $this->getPageData($params[0]);
        $smarty->assign('page', 'category');
        $smarty->assign('category_name', CategoryModel::getCategoryById($params[0]));
        $smarty->assign('categories', CategoryModel::getList());
        $smarty->assign('items', ItemModel::getList($params[0], 'DESC', $this->getLim($pagination)));
        $smarty->assign('category_id', $params[0]);
        $smarty->assign('pagination', $pagination);
        $smarty->display('category.tpl');
    }

    public function analytic()
    {
        global $smarty, $params;

        $pagination = $this->getPageDataAnalytic(isset($params[0]) ? $params[0] : 1);
    
        $smarty->assign('page', 'analytic');
        $smarty->assign('categories', CategoryModel::getList());
        $smarty->assign('items', ItemModel::getListAnalytic('DESC', $this->getLim($pagination)));
        $smarty->assign('category_id', 'analytic');
        $smarty->assign('pagination', $pagination);
        $smarty->display('analytic.tpl');
    }

    private function getPageDataAnalytic()
    {
        global $params;

        $pagination = [];
        $pagination['count'] = ItemModel::getListAnalyticCount();
        $pagination['currentPage'] = isset($params[1]) ? $params[1] : 1;
        $pagination['pagesCount'] = ceil($pagination['count']/5);
        $pagination['next'] = ($pagination['currentPage'] < $pagination['pagesCount']) ? $pagination['currentPage'] + 1 : 0;
        $pagination['prev'] = ($pagination['currentPage'] > 1) ? $pagination['currentPage'] - 1 : 0;

        return $pagination;
    }

    private function getPageData($catId)
    {
        global $params;

        $pagination = [];
        $pagination['count'] = ItemModel::getListCount($catId);
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
