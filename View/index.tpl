{extends file="layout.tpl"}
{block name=body}


        <div class="col-sm-6">
            <ol class="breadcrumb">
                <li><a href="/">Main</a></li>
            </ol>

            <div class="row">
                {if !count($items)}
                    <img src="https://cdn.wpml.org/wp-content/uploads/2015/02/555113-no_items_found.png" style="width: 100%;">
                {else}
                    <h3>Latest news</h3>
                    {foreach $news_main as $category}

                        <h4>{$category['name']}</h4>
                {foreach $items as $index}
                    {foreach $index as $ind => $item}
                   {if $item['category_id'] == $category['id']}
<span style="font-size: small">{date_format(date_create($item['news_date']), 'd.m.Y H:i')}</span>    <a href="/item/show/{$item['id']}">{$item['name']}</a>
                <div >

                </div>
                    {/if}
                    {/foreach}
                {/foreach}

                        <div style="clear: both;"></div>
                {/foreach}
                {/if}
            </div>
        </div>


{/block}
