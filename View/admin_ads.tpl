{extends file="admin_layout.tpl"}
{block name=body}

    <h3>Ads Units</h3>
    <table border="1" class="table">
        <thead>
        <th>ID</th>
        <th style="width: 7%; text-align: center;">Location</th>
        <th>Ad Title</th>
        <th style="width: 10%; text-align: center;">Price</th>
        <th>Firm</th>
        <th style="width: 5%; text-align: center;">Published</th>
        <th style="width: 10%; text-align: center;">Weight</th>
        <th>Update</th>
        </thead>
        <tbody>
            {foreach $ads as $index => $ad}
                <form action="/admin/ads/update" method="POST">
                <tr>

                        <td>{$ad['id']}</td>
                        <td>{if $ad['id'] <= 4 }Left {else} Right {/if}</td>
                        <td><input type="text" class="form-control" name="name" id="name" value="{$ad['name']}"></td>
                        <td><input type="text" class="form-control" name="price" id="price" value="{$ad['price']}"></td>
                        <td><input type="text" class="form-control" name="firm" id="firm" value="{$ad['firm']}"></td>
                        <td><input type="checkbox" class="form-control" name="moderation" id="moderation" {if $ad['moderation'] == 1}checked{/if} value="1"></td>
                        <td><input type="text" class="form-control" name="weight" id="weight" value="{$ad['weight']}"></td>
                        <td><button type="submit" class="btn btn-warning">Update</button></td>

                    </tr>
                    <input type="hidden" name="id" value="{$ad['id']}">
                </form>
            {/foreach}
        </tbody>
    </table>

{/block}
