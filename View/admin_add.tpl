

<!--http://dropmefiles.com/158851-->


{extends file="admin_layout.tpl"}
{block name=body}
    <h3>Add Article</h3>
    <form action="/admin/add/create" method="POST" enctype="multipart/form-data">
        <div class="form-group">
            <label for="name">Title Article:</label>
            <input type="text" class="form-control" name="name" id="name">
        </div>
        <div class="form-group">
            <label for="description">Text Article:</label>
            <textarea type="text" class="form-control" name="description" id="description" style="min-height: 150px;"></textarea>
        </div>
        <div class="form-group">
            <label for="tag">Tags <span style="font-size: 12px;">(Sample:tag1,tag2,tag3,...)</span>:</label>
            <input type="text" class="form-control" name="tag" id="tag">
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
            <label for="count">Add picture to the Article:</label>
            <input type="file" class="form-control" name="file" id="file">
        </div>

        <label for="moderation">Аналитика:</label>
        <input type="checkbox" class="form-control" name="analytic" id="analytic">

        <button type="submit" class="btn btn-success">Добавить</button>
    </form>

{/block}
