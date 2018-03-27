

<!--http://dropmefiles.com/158851-->


{extends file="admin_layout.tpl"}
{block name=body}
    <h3>Edit Article <a href="/admin/item/remove/{$items['id']}?a=1" type="submit" class="btn btn-danger">Delete</a>
        <a href="/admin/addcomment/index/{$items['id']}?a=1" type="submit" class="btn btn-info">Add Comment</a>
    </h3>
    <form action="/admin/item/update" method="POST" enctype="multipart/form-data">
        <div class="form-group">
            <label for="name">Title Article:</label>
            <input type="text" class="form-control" name="name" id="name" value="{$items['name']}">
        </div>
        <div class="form-group">
            <label for="description">Text Article:</label>
            <textarea type="text" class="form-control" name="description" id="description" style="min-height: 150px;">{$items['description']}</textarea>
        </div>
        <div class="form-group">
            <label for="tag">Tags <span style="font-size: 12px;">(Sample:tag1,tag2,tag3,...)</span>:</label>
            <input type="text" class="form-control" name="tag" id="tag" value="{$items['tag']}">
        </div>
        <div class="form-group">
            <label for="category_id">Section of news:</label>
            <select class="form-control" name="category_id" id="category_id">
            {foreach $categories as $category}
                <option value="{$category['id']}" >{$category['name']}</option>
            {/foreach}
            </select>
        </div>
        <div class="form-group">
            <label for="count">Add picture to the Article:</label><br>
            <img src="/files/show/{$items['id']}" style="height: 180px"><br>
            <input type="file" name="file" placeholder="file" style="width: 200px;">
        </div>

        <label for="moderation">Add Article to Analitic Section:</label>
        <input type="checkbox" class="form-control" name="analytic" id="analytic" {if ($items['analytic'] == 1)} checked="1" {/if}>

        <input type="hidden" name="id" value="{$items['id']}">
        <button type="submit" class="btn btn-success">Update</button>
    </form>

{/block}
