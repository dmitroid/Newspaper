{extends file="admin_layout.tpl"}
{block name=body}

    <h3>Change color theme</h3>
    <table border="1" class="table">
        <thead>
        <th style="width: 20%; text-align: center;">Block</th>
        <th>Color <span style="font-size: 12px;">(Sample: red, green, #cccccc,...)</span></th>
        <th style="width: 10%; text-align: center;">Update</th>
        </thead>
        <tbody>
            {foreach $blocks as $index => $block}
                <form action="/admin/theme/update" method="POST">
                <tr>
                        <td><p>{$block['block']}</p></td>
                        <td><input type="text" class="form-control" name="color" id="color" value="{$block['color']}"></td>

                        <td><button type="submit" class="btn btn-warning">Update</button></td>

                    </tr>
                    <input type="hidden" name="id" value="{$block['id']}">
                </form>
            {/foreach}
        </tbody>
    </table>

{/block}
