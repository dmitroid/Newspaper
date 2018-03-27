<?php
class SearchController extends ParentController
{
    public function index()
    {
        global $smarty;

        $term = trim(strip_tags($_GET['term']));
        $getParams = $this->getParams();
        $pagination = $this->getPageData($getParams);
        $category_ids = [];
        if (isset($_GET['category_id'])) {
            foreach($_GET['category_id'] as $cat_id) {
                $category_ids[$cat_id] = $cat_id;
            }
        }

        $smarty->assign('categories', CategoryModel::getList());
        $smarty->assign('all_categories', CategoryModel::getListAll());
        $smarty->assign('items', ItemModel::getSearchList($getParams, 'DESC', $this->getLim($pagination)));
        $smarty->assign('pagination', $pagination);
        $smarty->assign('category_id', 0);
        $smarty->assign('category_ids', $category_ids);
        $smarty->assign('term', $term);
        $smarty->assign('get', $_GET);
        $smarty->assign('page', 'search');
        $smarty->display('search.tpl');
    }

    private function getParams()
    {
        $getParams = [];
        if (isset($_GET['term'])) {
            $getParams['term'] = strip_tags($_GET['term']);
        }

        if (isset($_GET['category_id']) && $_GET['category_id']) {
            $categoryIds = [];
            foreach($_GET['category_id'] as $cat_id) {
                $categoryIds[] = strip_tags($cat_id);
            }
            $getParams['category_ids'] = $categoryIds;
        }

        if (isset($_GET['date_start']) && $_GET['date_start']) {
            $getParams['date_start'] = strip_tags($_GET['date_start']);
        }

        if (isset($_GET['date_end']) && $_GET['date_end']) {
            $getParams['date_end'] = strip_tags($_GET['date_end']);
        }

        if (isset($_GET['tags']) && $_GET['tags']) {
            $tags = explode(',', strip_tags($_GET['tags']));
            $tagsArray = [];
            foreach($tags as $tag) {
                $tagsArray[] = trim($tag);
            }
            $getParams['tags'] = $tagsArray;
        }

        return $getParams;
    }

    private function getPageData($getParams)
    {
        global $params;

        $pagination = [];
        $pagination['count'] = ItemModel::getSearchListCount($getParams);
        $pagination['currentPage'] = isset($params[0]) ? $params[0] : 1;
        $pagination['pagesCount'] = ceil($pagination['count'] / 5);
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
