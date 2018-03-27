

<!--http://dropmefiles.com/158851-->


{extends file="admin_layout.tpl"}
{block name=body}
    <h3>Add Comment</h3>
    <form action="/admin/addcomment/create" method="POST">
        <div class="form-group">
            <a href="/admin/item/show/{$item['id']}">{$item['name']}</a>
        </div>
        <div class="form-group">
            <label for="comment">Comment Text:</label>
            <textarea type="text" class="form-control" name="comment" id="comment" style="min-height: 150px;"></textarea>
        </div>
        <div class="form-group">
            <label for="moderation">Moderation is passed:</label>
            <input type="checkbox" class="form-control" name="moderation" id="moderation" checked="1">

            <input type="hidden" name="item_id" value="{$item['id']}">
        <button type="submit" class="btn btn-success">Create</button>
    </form>

{/block}
