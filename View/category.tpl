{extends file="layout.tpl"}
{block name=body}

        <div class="col-sm-6">
            <ol class="breadcrumb">
                <li><a href="/">Main</a></li>
                <li><a href="#">{$category_name[0]}</a></li>
            </ol>

            <div class="row">
                {if !count($items)}
                    <img src="https://cdn.wpml.org/wp-content/uploads/2015/02/555113-no_items_found.png" style="width: 100%;">
                {else}
                    {foreach $items as $index => $item}
                        <table class="table">
                            <tbody>
                            <tr>
                                <td>
                                    <span style="font-size: small">{date_format(date_create($item['news_date']), 'd.m.Y')}</span> <a href="/item/show/{$item['id']}">{$item['name']}</a>
                                </td>
                            </tr>
                            </tbody>

                        </table>
                    {/foreach}
                {/if}
            </div>
            <nav aria-label="Page navigation" style="text-align: center;">
                <div id="hidden-pagination" style="border: 3px #ccc solid; width: 116px; margin-left: 219px;position: relative; display: none;">
                    <ul class="pagination" style="margin: 5px;">
                        {for $i=1 to $pagination['pagesCount']}
                            <li><a href="/main/show/{$category_id}/{$i}">{$i}</a></li>
                        {/for}
                    </ul>
                </div>
                <div>
                    <ul class="pagination" style="margin: 5px;">
                        <li><a href="/main/show/{$category_id}/1">1</a></li>
                        <li><a href="javascript: showPagination();">...</a></li>
                        <li><a href="/main/show/{$category_id}/{$pagination['pagesCount']}">{$pagination['pagesCount']}</a></li>
                    </ul>
                </div>

                <ul class="pagination" style="margin: 0px;">
                    <li>
                        <a {if ($pagination['prev'] != 0)} href="/main/show/{$category_id}/{$pagination['prev']}" {/if} aria-label="Previous">
                            <span aria-hidden="true">&laquo;</span>
                        </a>
                    </li>
                    <li><a>{$pagination['currentPage']}</a></li>
                    <li>
                        <a {if ($pagination['next'] != 0)} href="/main/show/{$category_id}/{$pagination['next']}" {/if} aria-label="Next">
                            <span aria-hidden="true">&raquo;</span>
                        </a>
                    </li>
                </ul>
            </nav>
        </div>


{/block}
