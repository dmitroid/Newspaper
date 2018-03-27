{extends file="layout.tpl"}
{block name=body}
    <script src="/View/js/views.js"></script>

        <div class="col-sm-6">
            <ol class="breadcrumb">
                <li><a href="/">Main</a></li>
                <li><a href="/main/show/{$category_id}">{$category_name[0]}</a></li>
                <li><a href="#">{$item[0]['name']}</a></li>
            </ol>

            <div class="row">
                {if !count($item)}
                    <img src="https://cdn.wpml.org/wp-content/uploads/2015/02/555113-no_items_found.png" style="width: 100%;">
                {else}
                    {foreach $item as $index => $news}
                        <input type="hidden" name="itemId" id="itemId" value="{$news['id']}">
                        <div class="col-sm-12">
                            <h1>{$news['name']}</h1>
                            <p>{$news['news_date']}</p>
                            <span>Views: <i class="glyphicon glyphicon-eye-open"></i> <span id="all-views">{$news['shows']}</span></span>
                        </div>
                        <div class="col-sm-12">
                            <span>Read Now: <span id="current-views">3</span></span>
                        </div>
                        <div class="col-sm-12">
                            <img src="/files/show/{$news['id']}" alt="{$news['name']}" title="{$news['name']}" style="width: 550px">
                        </div>
                        <div class="col-sm-12" style="padding-top: 20px;">
                            {$news['description']}
                        </div>
                    {/foreach}
                {/if}
            </div>

            <div class="row">
                <h4>News tags:</h4>
                {foreach $articletags as $tag}
                    <a href="/search/index?term={$tag}">{$tag}</a>
                {/foreach}
            </div>


            <div class="row">
                {if $user_id != 0}
                <div class="leave-comment">
                    <h3>Leave comment</h3>
                    <form role="form" action="/comments/create" method="post">
                        <div class="form-group">
                            <input type="hidden" name="item_id" value="{$item[0]['id']}">
                            <input type="hidden" name="user_name" value="{$smarty.session.user.login}">
                            <input type="hidden" name="user_id" value="{$smarty.session.user.id}">
                            <input type="hidden" name="rating" value="0">
                            <input type="hidden" name="parent_id" value="0">
                            <input type="hidden" name="moderation" value="1">
                            <textarea class="form-control" name="comment" id="text-comment" placeholder="Введите ваш комментраий"></textarea>
                        </div>
                        <button type="submit" class="btn btn-success">Send</button>
                    </form>
                </div>
                {/if}

                <div class="comments">
                    <h4 class="title-comments">Comments ({count($comments)})</h4>
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
                                    <span class="vote plus" title="Нравится" onclick="addVote({$comment['id']});">
                                        <i class="glyphicon glyphicon-thumbs-up"></i>
                                    </span>
                                    <span class="rating" id="rating-{$comment['id']}">
                                        {$comment['rating']}
                                    </span>
                                    <span class="vote minus" title="Не нравится" onclick="reduceVote({$comment['id']});">
                                        <i class="glyphicon glyphicon-thumbs-down"></i>
                                    </span>
                                    <span class="devide">
                                       |
                                    </span>
                                    {if $user_id != 0}
                                    <span class="comment-reply">
                                        <a href="javascript: addAnswer({$comment['id']});" class="reply">reply</a>
                                    </span>
                                        <div id="answer-{$comment['id']}" style="display: none;">
                                            <form role="form" action="/comments/create" method="post">
                                                <div class="form-group">
                                                    <input type="hidden" name="item_id" value="{$item[0]['id']}">
                                                    <input type="hidden" name="user_name" value="{$smarty.session.user.login}">
                                                    <input type="hidden" name="user_id" value="{$smarty.session.user.id}">
                                                    <input type="hidden" name="rating" value="0">
                                                    <input type="hidden" name="parent_id" value="{$comment['id']}">
                                                    <input type="hidden" name="moderation" value="1">
                                                    <textarea class="form-control" name="comment" id="text-comment" placeholder="Введите ваш комментраий"></textarea>
                                                </div>
                                                <button type="submit" class="btn btn-success">Send</button>
                                            </form>
                                        </div>
                                    {/if}

                                    {if array_key_exists('children', $comment)}
                                        {foreach $comment['children'] as $child}
                                            <div class="media">
                                                <div class="media-left">
                                                    <a href="#">
                                                        <img class="media-object img-rounded" src="/files/show/555" width="30" alt="">
                                                    </a>
                                                </div>
                                                <div class="media-body">
                                                    <div class="media-heading">
                                                        <div class="author">{$child['user_name']}</div>
                                                        <div class="metadata">
                                                            <span class="date">{$child['date_time']}</span>
                                                        </div>
                                                    </div>
                                                    <div class="media-text text-justify">{$child['comment']}</div>
                                                    <div class="footer-comment">
                                                        <span class="vote plus" title="Нравится" onclick="addVote({$child['id']});">
                                                            <i class="glyphicon glyphicon-thumbs-up"></i>
                                                        </span>
                                                                            <span class="rating" id="rating-{$child['id']}">
                                                            {$child['rating']}
                                                        </span>
                                                                            <span class="vote minus" title="Не нравится" onclick="reduceVote({$child['id']});">
                                                            <i class="glyphicon glyphicon-thumbs-down"></i>
                                                        </span>
                                                    </div>
                                                </div>
                                            </div>
                                        {/foreach}
                                    {/if}
                                </div>
                            </div>
                        </li>
                        {/foreach}
                    </ul>

                </div>
            </div>
        </div>


{/block}
