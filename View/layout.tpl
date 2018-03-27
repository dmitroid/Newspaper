<html>
<head>
    <title>Newspaper</title>
    <meta http-equiv="Content-type" content="text/html; charset=utf-8" />

    <script>
        var availableTags = [
            {foreach $tags as $tag}
                '{$tag['tag']}',
            {/foreach}
        ];
    </script>

    <!-- Алерт показывается при любом переходе со страницы, не только при закрытии окна. Поэтому он отключен. -->
    <script type="text/javascript">
        //window.onbeforeunload = function () {
          //  return 'Are you really want to perform the action?';
        //}
    </script>

    <link rel="stylesheet" href="//code.jquery.com/ui/1.12.1/themes/base/jquery-ui.css">
    <link rel="stylesheet" href="/resources/demos/style.css">
    <script src="https://code.jquery.com/jquery-1.12.4.js"></script>
    <script src="https://code.jquery.com/ui/1.12.1/jquery-ui.js"></script>
    <script src="/View/js/pagination.js"></script>
    <script src="/View/js/autocomplete.js"></script>
    <script src="/View/js/comment.js"></script>
    <script src="/View/js/views.js"></script>
    <script src="/View/js/ads.js"></script>
    <link rel="stylesheet" href="/View/css/style.css">
    <script src="/View/js/popup.js"></script>
    <link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.7/css/bootstrap.min.css" integrity="sha384-BVYiiSIFeK1dGmJRAkycuHAHRg32OmUcww7on3RYdg4Va+PmSTsz/K68vbdEjh4u" crossorigin="anonymous">
    <link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.7/css/bootstrap-theme.min.css" integrity="sha384-rHyoN1iRsVXV4nD0JutlnGaslCJuC7uwjduW9SVrLvRYooPp2bWYgmgJQIXwl/Sp" crossorigin="anonymous">
    <script src="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.7/js/bootstrap.min.js" integrity="sha384-Tc5IQib027qvyjSMfHjOMaLkfuWVxZxUPnCJA7l2mCWNIpG9mGCD8wGNIcPD7Txa" crossorigin="anonymous"></script>
    <style type="text/css">
        .carousel{
            background: #2f4357;
            margin-top: 20px;
        }
        .carousel .item{
            min-height: 280px; /* Prevent carousel from being distorted if for some reason image doesn't load */
        }
        .carousel .item img{
            margin: 0 auto; /* Align slide image horizontally center */
            max-height: 280px;
        }
        .bs-example{
            margin: 20px;
        }
        .carousel-caption a {
            color: white;
        }
    </style>
    <!-- Comments -->
    <style>
        html {
            font-size: 16px;
        }

        .media-body .author {
            display: inline-block;
            font-size: 1rem;
            color: #000;
            font-weight: 700;
        }

        .media-body .metadata {
            display: inline-block;
            margin-left: .5rem;
            color: #777;
            font-size: .8125rem;
        }

        .footer-comment {
            color: #777;
        }

        .vote.plus:hover {
            color: green;
        }

        .vote.minus:hover {
            color: red;
        }

        .vote {
            cursor: pointer;
        }

        .comment-reply a {
            color: #777;
        }

        .comment-reply a:hover, .comment-reply a:focus {
            color: #000;
            text-decoration: none;
        }

        .devide {
            padding: 0px 4px;
            font-size: 0.9em;
        }

        .media-text {
            margin-bottom: 0.25rem;
        }

        .title-comments {
            font-size: 1.4rem;
            font-weight: bold;
            line-height: 1.5rem;
            color: rgba(0, 0, 0, .87);
            margin-bottom: 1rem;
            padding-bottom: .25rem;
            border-bottom: 1px solid rgba(34, 36, 38, .15);
        }
    </style>

</head>
<body style="background-color: {$cl[1]['color']}">

<nav class="navbar navbar-default">
    <div class="container-fluid">
        <!-- Brand and toggle get grouped for better mobile display -->
        <div class="navbar-header">
            <button type="button" class="navbar-toggle collapsed" data-toggle="collapse" data-target="#bs-example-navbar-collapse-1" aria-expanded="false">
                <span class="sr-only">Toggle navigation</span>
                <span class="icon-bar"></span>
                <span class="icon-bar"></span>
                <span class="icon-bar"></span>
            </button>
            <a class="navbar-brand" href="/">News</a>
        </div>

        <!-- Collect the nav links, forms, and other content for toggling -->
        <div class="collapse navbar-collapse" id="bs-example-navbar-collapse-1">
            <ul class="nav navbar-nav">
                {if isset($smarty.session.user.login) && $smarty.session.user.role > 0}
                    <li><a href="/admin/categories">Admin Panel</a></li>
                {/if}

            </ul>

            <ul class="nav navbar-nav navbar-right">
                <form class="navbar-form navbar-left" role="search" method="get" action="/search/index">
                    <div class="form-group">
                        <input type="text" class="form-control" placeholder="Word for search" id="search-input" name="term">
                    </div>
                    <button type="submit" class="btn btn-default"><span class = "glyphicon glyphicon-search"></span> Search</button>
                </form>
                {if !isset($smarty.session.user.login)}
                    <li class=""><a href="/auth/login">Login<span class="sr-only"></span></a></li>
                    <li class=""><a href="/auth/register">Register<span class="sr-only"></span></a></li>
                {else}

                    <li class="dropdown">
                        <a href="#" class="dropdown-toggle" data-toggle="dropdown" role="button" aria-haspopup="true" aria-expanded="false">{$smarty.session.user.login}<span class="caret"></span></a>
                        <ul class="dropdown-menu">
                            <li><a href="/auth/logout">Logout</a></li>
                        </ul>
                    </li>
                {/if}

            </ul>
        </div><!-- /.navbar-collapse -->
    </div><!-- /.container-fluid -->
</nav>

<div class="container">
    <div id="popup" style="width: 400px; position: fixed;z-index: 1; background-color: #fff; padding: 10px; border: 3px #000 solid; left: 50%; top: 40%; margin-left: -200px; margin-top: -75px; display: none;">
        <div style="align: right; display: flow;"><a href="javascript: return false;" onclick="closePopup();">Close</a></div>
        <form role="form">
            <h3>Subscribe to newsletter</h3>
            <div class="form-group">
                <label for="email">Email</label>
                <input type="email" class="form-control" id="email" placeholder="Введите email">
            </div>
            <div class="form-group">
                <label for="pass">Password</label>
                <input type="email" class="form-control" id="email" placeholder="Введите Ваше имя и фамилию">
            </div>
            <button type="submit" class="btn btn-success" onclick="closePopup(); return false;">Subscribe</button>
        </form>
    </div>


    <nav class="navbar navbar-inverse" role="navigation">
        <div class="container-fluid" style="background-color: {$cl[0]['color']}">
            <div class="collapse navbar-collapse" id="bs-example-navbar-collapse-1">
                <ul class="nav navbar-nav">

                    {foreach $categories as $category}
                        <li role="presentation" class="{if array_key_exists('children', $category)} dropdown {/if} {if ($category_id == $category['id'])} active{/if} ">
                            <a {if array_key_exists('children', $category)} class="dropdown-toggle" data-toggle="dropdown" {/if} href="/main/show/{$category['id']}">{$category['name']} {if array_key_exists('children', $category)} <span class="caret"></span> {/if}</a>
                            {if array_key_exists('children', $category)}
                                <ul class="dropdown-menu" role="menu">
                                    {foreach $category['children'] as $child}
                                        <li><a href="/main/show/{$child['id']}">{$child['name']}</a></li>
                                    {/foreach}
                                </ul>
                            {/if}
                        </li>
                    {/foreach}
                    <li {if ($category_id == 'analytic')} class="active"{/if}>
                        <a href="/main/analytic">Analitic</a>
                    </li>
                </ul>
            </div><!-- /.navbar-collapse -->
        </div><!-- /.container-fluid -->
    </nav>
    {if $page != 'search'}
    {if $page != 'login'}
    {if $page != 'register'}
    <div class="row">
        {if $page == 'main'}
        <div class="bs-example">
            <div id="myCarousel" class="carousel slide" data-ride="carousel">
                <!-- Carousel indicators -->
                <ol class="carousel-indicators">
                    <li data-target="#myCarousel" data-slide-to="0" class="active"></li>
                    <li data-target="#myCarousel" data-slide-to="1"></li>
                    <li data-target="#myCarousel" data-slide-to="2"></li>
                    <li data-target="#myCarousel" data-slide-to="3"></li>
                </ol>
                <!-- Wrapper for carousel items -->
                <div class="carousel-inner">
                    <div class="item active">
                        <img src="/files/show/{$banner[0]['id']}" width="100%" alt="Second Slide">
                        <div class="carousel-caption d-none d-md-block">
                            <a href="/item/show/{$banner[0]['id']}"><h3>{$banner[0]['name']}</h3></a>

                        </div>
                    </div>
                    {section name=banners loop=$banner start="1"}
                        <div class="item">
                            <img src="/files/show/{$banner[banners]['id']}" width="100%" alt="Second Slide">
                            <div class="carousel-caption d-none d-md-block">
                                <a href="/item/show/{$banner[banners]['id']}"><h3>{$banner[banners]['name']}</h3></a>

                            </div>
                        </div>
                    {/section}

                </div>
                <!-- Carousel controls -->
                <a class="carousel-control left" href="#myCarousel" data-slide="prev">
                    <span class="glyphicon glyphicon-chevron-left"></span>
                </a>
                <a class="carousel-control right" href="#myCarousel" data-slide="next">
                    <span class="glyphicon glyphicon-chevron-right"></span>
                </a>
            </div>
        </div>
        {/if}

        <div class="row">
            <div class="col-sm-3">
                <div class="panel panel-info">
                    <div class="panel-heading">Top 5 commentators </div>
                    <div class="panel-body">
                        <ol>
                            {foreach $topcommentators as $commentator}
                                <li><a href="/user/comments/{$commentator['user_id']}">{$commentator['user_name']}</a> -> {$commentator['res']} </li>
                            {/foreach}
                        </ol>
                    </div>
                </div>
                {foreach $ads_left as $ad}
                    <div onmouseover="changeAds({$ad['id']})" onmouseout="changeBackAds({$ad['id']})" id="adss-{$ad['id']}" class="panel panel-info">
                        <div class="panel-body">
                            <h4>{$ad['name']}</h4>
                            <p><span class="price-normal">Price: {$ad['price']}</span><span class="price-cheap" style="display: none;">Price: {$ad['price']*0.9}</span></p>
                            <p>Firm: {$ad['firm']}</p>
                        </div>
                        <div class="panel-body" id="cupon">
                            Discount coupon:<br>XZ56-CVBf-NJG5<br>apply and save 10%
                        </div>
                    </div>
                {/foreach}
            </div>
    {/if}
            {/if}
            {/if}
    {block name=body}{/block}
            {if $page != 'search'}
            {if $page != 'login'}
            {if $page != 'register'}
            <div class="col-sm-3">
                <div class="panel panel-danger">
                    <div class="panel-heading">Top 3 by comments </div>
                    <div class="panel-body">
                        <ol>
                            {foreach $topitem as $item}
                                <li><a href="/item/show/{$item['id']}">{$item['name']}</a> -> {$item['res']} </li>
                            {/foreach}
                        </ol>
                    </div>
                </div>
                {foreach $ads_right as $ad}
                    <div onmouseover="changeAds({$ad['id']})" onmouseout="changeBackAds({$ad['id']})" id="adss-{$ad['id']}" class="panel panel-info">
                        <div class="panel-body">
                            <h4>{$ad['name']}</h4>
                            <p><span class="price-normal">Price: {$ad['price']}</span><span class="price-cheap" style="display: none;">Price: {$ad['price']*0.9}</span></p>
                            <p>Firm: {$ad['firm']}</p>
                        </div>
                        <div class="panel-body" id="cupon">
                            Discount coupon:<br>XZ56-CVBf-NJG5<br>apply and save 10%
                        </div>
                    </div>
                {/foreach}
            </div>
        </div>
</div>
    {/if}
    {/if}
    {/if}
<div class="row" style="width: 100%; height: 100px;"></div>
</body>
</html>
