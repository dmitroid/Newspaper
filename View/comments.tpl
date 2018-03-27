{extends file="layout.tpl"}
{block name=body}
        <div class="col-sm-6">
            <ol class="breadcrumb">
                <li><a href="/">Main</a></li>
            </ol>

            <div class="row">
                <div class="comments">
                    <h4 class="title-comments">Comments ({$pagination['count']})</h4>
                    <ul class="media-list">
                        {foreach $comments as $comment}
                            <li class="media">
                                <div class="media-left">
                                    <a href="#">
                                        <img class="media-object img-rounded" src="/files/show/555" width="30" alt="">
                                    </a>
                                </div>
                                <div class="media-body">
                                    <div class="media-heading">
                                        <div class="author">{$comment['user_name']}</div>
                                        <div class="metadata">
                                            <span class="date">{$comment['date_time']}</span>
                                        </div>
                                    </div>
                                    <div class="media-text text-justify">{$comment['comment']}</div>
                                    <div class="footer-comment">
                                    <span class="vote plus" title="Нравится">
                                        <i class="glyphicon glyphicon-thumbs-up"></i>
                                    </span>
                                        <span class="rating">
                                        {$comment['rating']}
                                    </span>
                                        <span class="vote minus" title="Не нравится">
                                        <i class="glyphicon glyphicon-thumbs-down"></i>
                                    </span>
                                        <span class="devide">
                                       |
                                    </span>
                                        <span class="comment-reply">
                                        <a href="#" class="reply">reply</a>
                                    </span>
                                    </div>
                                </div>
                            </li>
                        {/foreach}
                    </ul>

                </div>
            </div>
            <nav aria-label="Page navigation" style="text-align: center;">
                <div id="hidden-pagination" style="border: 3px #ccc solid; width: 116px; margin-left: 219px;position: relative; display: none;">
                    <ul class="pagination" style="margin: 5px;">
                        {for $i=1 to $pagination['pagesCount']}
                            <li><a href="/user/comments/{$user_id}/{$i}">{$i}</a></li>
                        {/for}
                    </ul>
                </div>
                <div>
                    <ul class="pagination" style="margin: 5px;">
                        <li><a href="/user/comments/{$user_id}/1">1</a></li>
                        <li><a href="javascript: showPagination();">...</a></li>
                        <li><a href="/user/comments/{$user_id}/{$pagination['pagesCount']}">{$pagination['pagesCount']}</a></li>
                    </ul>
                </div>

                <ul class="pagination" style="margin: 0px;">
                    <li>
                        <a {if ($pagination['prev'] != 0)} href="/user/comments/{$user_id}/{$pagination['prev']}" {/if} aria-label="Previous">
                            <span aria-hidden="true">&laquo;</span>
                        </a>
                    </li>
                    <li><a>{$pagination['currentPage']}</a></li>
                    <li>
                        <a {if ($pagination['next'] != 0)} href="/user/comments/{$user_id}/{$pagination['next']}" {/if} aria-label="Next">
                            <span aria-hidden="true">&raquo;</span>
                        </a>
                    </li>
                </ul>
            </nav>
        </div>

{/block}
