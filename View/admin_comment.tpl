

<!--http://dropmefiles.com/158851-->


{extends file="admin_layout.tpl"}
{block name=body}
    <h3>Edit Comment <a href="/admin/comment/remove/{$comment_id}" type="submit" class="btn btn-danger">Delete</a></h3>
    <form action="/admin/comment/update" method="POST">
        <div class="form-group">
            <a href="/admin/item/show/{$item['id']}">{$item['name']}</a>
        </div>
        <div class="form-group">
            <label for="comment">Comment Text:</label>
            <textarea type="text" class="form-control" name="comment" id="comment" style="min-height: 150px;">{$comment['comment']}</textarea>
        </div>
        <div class="form-group">
            <label for="moderation">Moderation is passed:</label>
            <input type="checkbox" class="form-control" name="moderation" id="moderation" {if ($comment['moderation'] == 1)} checked="1" {/if}>

            <input type="hidden" name="item_id" value="{$item['id']}">
            <input type="hidden" name="id" value="{$comment_id}">
            <button type="submit" class="btn btn-success">Update</button>
    </form>

{/block}
