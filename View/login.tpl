{extends file="layout.tpl"}
{block name=body}
    <h3>Login</h3>
    <!--<form action="/auth/login" method="POST">-->
    <div style="color: red;" id="error"></div>
        <div class="form-group">
            <label for="login">Login:</label>
            <input type="text" class="form-control" name="login" id="login">
        </div>
        <div class="form-group">
            <label for="pwd">Password:</label>
            <input type="password" class="form-control" name="pass" id="pwd">
        </div>
        <button type="submit" class="btn btn-success" id="btn">Login</button>
    <!--</form>-->
    Has no account? <a href="/auth/register"> Register </a>


    <script>
        $(document).ready(function() {
            $("#btn").on("click", function () {
                $("#error").empty();
                var data = {
                    login: $("#login").val(),
                    pass: $("#pwd").val()
                };


                console.log(data);

                $.ajax({
                    url: "/auth/login",
                    data: data,
                    type: "POST",
                    success: function (res) {
                        window.location = "/";
                    },
                    error: function (res) {
                        $("#error").text(res.responseJSON.message);
                    }
                });

                /*$.post("/auth/login", data, function (res) {
                    console.log("RES");
                    if(res.status) {
                        window.location = "/";
                        return;
                    }


                }).fail(function(res) {
                    $("#error").text(res.responseJSON.message);
                })*/
            });
        });
    </script>
{/block}
