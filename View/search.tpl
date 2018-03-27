{extends file="layout.tpl"}
{block name=body}
    <style>
        .filter {
            margin-bottom: 10px;
        }
        .example {
            font-style: normal;
            font-size: 10px;
        }
    </style>

    <div class="row">
        <div class="col-sm-3">
            <h3>Filter</h3>
            <form action="/search/index" method="get">
                <div id="parent">
                    <div class="filter">
                        <label for="cat_id">Category</label>
                        <select name="category_id[]" multiple id="cat_id">
                            {foreach $all_categories as $cat}
                                <option value="{$cat['id']}" {if array_key_exists($cat['id'], $category_ids)}selected{/if}>{$cat['name']}</option>
                            {/foreach}
                        </select>
                    </div>
                    <div class="filter">
                        <label for="date_start">Date Start</label>
                        <input type="date" name="date_start" id="date_start" value="{if array_key_exists('date_start', $get)}{$get['date_start']}{/if}"/>
                    </div>
                    <div class="filter">
                        <label for="date_end">Date End</label>
                        <input type="date" name="date_end" id="date_end" value="{if array_key_exists('date_end', $get)}{$get['date_end']}{/if}"/>
                    </div>
                    <div class="filter">
                        <label for="tags">Tags <span class="example">e.g. "news,usa,politics"</span></label>
                        <input type="tags" name="tags" id="tags" value="{if array_key_exists('tags', $get)}{$get['tags']}{/if}"/>
                    </div>
                    <input type="hidden" name="term" value="{if array_key_exists('term', $get)}{$get['term']}{/if}">
                    <button type="submit" class="btn btn-success" >Filter</button>
                </div>
            </form>
        </div>
        <div class="col-sm-6">
            <h2>
                Search by: {$term}
            </h2>



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
                            <li><a href="/search/index/{$i}?term={$term}">{$i}</a></li>
                        {/for}
                    </ul>
                </div>
                <div>
                    <ul class="pagination" style="margin: 5px;">
                        <li><a href="/search/index/1?term={$term}">1</a></li>
                        <li><a href="javascript: showPagination();">...</a></li>
                        <li><a href="/search/index/{$pagination['pagesCount']}?term={$term}">{$pagination['pagesCount']}</a></li>
                    </ul>
                </div>

                <ul class="pagination" style="margin: 0px;">
                    <li>
                        <a {if ($pagination['prev'] != 0)} href="/search/index/{$pagination['prev']}?term={$term}" {/if} aria-label="Previous">
                            <span aria-hidden="true">&laquo;</span>
                        </a>
                    </li>
                    <li><a>{$pagination['currentPage']}</a></li>
                    <li>
                        <a {if ($pagination['next'] != 0)} href="/search/index/{$pagination['next']}?term={$term}" {/if} aria-label="Next">
                            <span aria-hidden="true">&raquo;</span>
                        </a>
                    </li>
                </ul>
            </nav>
        </div>
        <div class="col-sm-3">

        </div>
    </div>

{/block}
