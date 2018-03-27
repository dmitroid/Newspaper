{extends file="admin_layout.tpl"}
{block name=body}

    <h3>Section</h3>
    <table border="1" class="table">
        <thead>
        <th>ID</th>
        <th>Section name</th>
        <th>Weight Section</th>
        <th>ID parent Section <br><span style="font-size: 12px;">(if 0 - Section id Parent)</span></th>
        <th>Update</th>
        <th>Delete</th>
        </thead>
        <tbody>
            {foreach $categories as $index => $category}
                <form action="/admin/categories/update" method="POST">
                <tr id="tr_{$category['id']}">



                        <td>{$category['id']}</td>
                        <input type="hidden" name="id" value="{$category['id']}">
                        <td><input type="text" class="form-control" name="name" id="name" value="{$category['name']}"></td>
                        <td><input type="text" class="form-control" name="weight" id="name" value="{$category['weight']}"></td>
                        <td><input type="text" class="form-control" name="parent_id" id="parent_id" value="{$category['parent_id']}"


></td>
                        <td><button type="submit" class="btn btn-warning">Update</button></td>




                    <td><a class="btn btn-danger" onclick="remove({$category['id']})">Delete</a></td>
                    </tr>
                </form>
            {/foreach}
        </tbody>
    </table>
    <h3>Create new Section</h3>
    <form action="/admin/categories/create" method="POST">
        <div class="form-group">
            <label for="name">Section name:</label>
            <input type="text" class="form-control" name="name" id="name">
        </div>
        <div class="form-group">
            <label for="weight">Weight Section:</label>
            <input type="number" class="form-control" name="weight" id="weight">
        </div>
        <div class="form-group">
            <label for="category_id">Sub-section (default: Parent):</label>
            <select class="form-control" name="parent_id" id="parent_id">
                <option value="0" >Parent</option>
                {foreach $categories as $category}
                    <option value="{$category['id']}" >{$category['name']}</option>
                {/foreach}
            </select>
        </div>
        <button type="submit" class="btn btn-success">Create</button>
    </form>


    <script>
        function remove(id) {
            $.ajax({
                url: "/admin/categories/remove/" + id,
                type: "DELETE",
                success: function (res) {
                    $("#tr_" + id).hide();
                }
            });
        }
    </script>
{/block}
