

<!--http://dropmefiles.com/158851-->


{extends file="admin_layout.tpl"}
{block name=body}

    <h3>News List</h3>
    <table border="1" class="table" >
        <thead>
        <th style="width: 5%; text-align: center;">ID</th>
        <th style="width: 70%;">Title news</th>
        <th>Section of news</th>
        <th style="width: 10%; text-align: center;">Delete</th>
        </thead>
        <tbody>
        {foreach $items as $item}
                <tr>
                    <td style="text-align: center;">{$item['id']}</td>
                    <input type="hidden" name="id" value="{$item['id']}">
                    <td><a href="/admin/item/show/{$item['id']}"><i class="glyphicon glyphicon-eye-open"></i> {$item['name']} <span style="font-size: 12px;">(Edit)</span></a></td>
                    <td style="width: 140px"><span>
                        {foreach $categories as $category}
                         {if ($category['id'] == $item['category_id'])} {$category['name']} {/if}
                        {/foreach}
                        </span></td>
                    <td style="text-align: center;"><a href="/admin/items/remove/{$item['id']}?a=1" type="submit" class="btn btn-danger">Delete</a></td>
                </tr>
        {/foreach}
        </tbody>
    </table>
    <nav aria-label="Page navigation" style="text-align: center;">
        <div id="hidden-pagination" style="border: 3px #ccc solid; width: 116px; margin-left: 514px;position: relative; display: none;">
            <ul class="pagination" style="margin: 5px;">
                {for $i=1 to $pagination['pagesCount']}
                    <li><a href="/admin/items/index/{$i}">{$i}</a></li>
                {/for}
            </ul>
        </div>
        <div>
            <ul class="pagination" style="margin: 5px;">
                <li><a href="/admin/items/index/1">1</a></li>
                <li><a href="javascript: showPagination();">...</a></li>
                <li><a href="/admin/items/index/{$pagination['pagesCount']}">{$pagination['pagesCount']}</a></li>
            </ul>
        </div>

        <ul class="pagination" style="margin: 0px;">
            <li>
                <a {if ($pagination['prev'] != 0)} href="/admin/items/index/{$pagination['prev']}" {/if} aria-label="Previous">
                    <span aria-hidden="true">&laquo;</span>
                </a>
            </li>
            <li><a>{$pagination['currentPage']}</a></li>
            <li>
                <a {if ($pagination['next'] != 0)} href="/admin/items/index/{$pagination['next']}" {/if} aria-label="Next">
                    <span aria-hidden="true">&raquo;</span>
                </a>
            </li>
        </ul>
    </nav>
{/block}
