<!DOCTYPE html>

<!--[if IE 8]> <html lang="en" class="ie8"> <![endif]-->

<!--[if IE 9]> <html lang="en" class="ie9"> <![endif]-->

<!--[if !IE]><!--> <html lang="en"> <!--<![endif]-->

<!-- BEGIN HEAD -->

<head>

    <meta charset="utf-8" />

    <title>Metronic | Login Page</title>

    <meta content="width=device-width, initial-scale=1.0" name="viewport" />

    <meta content="" name="description" />

    <meta content="" name="author" />

    <!-- BEGIN GLOBAL MANDATORY STYLES -->

    <link href="/css/bootstrap.min.css" rel="stylesheet" type="text/css"/>

    <link href="/css/bootstrap-responsive.min.css" rel="stylesheet" type="text/css"/>

    <link href="/css/font-awesome.min.css" rel="stylesheet" type="text/css"/>

    <link href="/css/style-metro.css" rel="stylesheet" type="text/css"/>

    <link href="/css/style.css" rel="stylesheet" type="text/css"/>

    <link href="/css/style-responsive.css" rel="stylesheet" type="text/css"/>

    <link href="/css/default.css" rel="stylesheet" type="text/css" id="style_color"/>

    <link href="/css/uniform.default.css" rel="stylesheet" type="text/css"/>

    <!-- END GLOBAL MANDATORY STYLES -->

    <!-- BEGIN PAGE LEVEL STYLES -->

    <link href="/css/login.css" rel="stylesheet" type="text/css"/>

    <!-- END PAGE LEVEL STYLES -->

    <link rel="shortcut icon" href="/image/favicon.ico" />

</head>

<!-- END HEAD -->

<!-- BEGIN BODY -->

<body class="login">

    <!-- BEGIN LOGO -->

    <div class="logo">

        <img src="/image/logo-big.png" alt="" />

    </div>

    <!-- END LOGO -->

    <!-- BEGIN LOGIN -->

    <div class="content">

        <!-- BEGIN LOGIN FORM -->

        <form id="login-form" class="form-vertical login-form" action="/index/login">

            <h3 class="form-title">Login to your account</h3>

            <div class="alert alert-error hide">

                <button class="close" data-dismiss="alert"></button>

                <span>请输入正确的账号密码.</span>

            </div>

            <div class="control-group">

                <!--ie8, ie9 does not support html5 placeholder, so we just show field title for that-->

                <label class="control-label visible-ie8 visible-ie9">Username</label>

                <div class="controls">

                    <div class="input-icon left">

                        <i class="icon-user"></i>

                        <input class="m-wrap placeholder-no-fix" type="text" placeholder="Username" name="username"/>

                    </div>

                </div>

            </div>

            <div class="control-group">

                <label class="control-label visible-ie8 visible-ie9">Password</label>

                <div class="controls">

                    <div class="input-icon left">

                        <i class="icon-lock"></i>

                        <input class="m-wrap placeholder-no-fix" type="password" placeholder="Password" name="password"/>

                    </div>

                </div>

            </div>

            <div class="form-actions">

                <label class="checkbox">

                <!-- <input type="checkbox" name="remember" value="1"/> Remember me -->

                </label>

                <button type="submit" class="btn green pull-right">

                Login <i class="m-icon-swapright m-icon-white"></i>

                </button>

            </div>

            <div class="forget-password">

                <h4>Forgot your password ?</h4>

                <p>

                    no worries, click <a href="javascript:;" class="" id="forget-password">here</a>

                    to reset your password.

                </p>

            </div>

        </form>

        <!-- END LOGIN FORM -->

        <!-- BEGIN FORGOT PASSWORD FORM -->

        <form class="form-vertical forget-form" action="/index/login">

            <h3 class="">Forget Password ?</h3>

            <p>Enter your e-mail address below to reset your password.</p>

            <div class="control-group">

                <div class="controls">

                    <div class="input-icon left">

                        <i class="icon-envelope"></i>

                        <input class="m-wrap placeholder-no-fix" type="text" placeholder="Email" name="email" />

                    </div>

                </div>

            </div>

            <div class="form-actions">

                <button type="button" id="back-btn" class="btn">

                <i class="m-icon-swapleft"></i> Back

                </button>

                <button type="submit" class="btn green pull-right">

                Submit <i class="m-icon-swapright m-icon-white"></i>

                </button>

            </div>

        </form>

        <!-- END FORGOT PASSWORD FORM -->

        <!-- BEGIN REGISTRATION FORM -->

        <!--  -->

        <!-- END REGISTRATION FORM -->

    </div>

    <!-- END LOGIN -->

    <!-- BEGIN COPYRIGHT -->

    <div class="copyright">

        2013 &copy; Metronic. Admin Dashboard Template.

    </div>

    <!-- END COPYRIGHT -->

    <!-- BEGIN JAVASCRIPTS(Load javascripts at bottom, this will reduce page load time) -->

    <!-- BEGIN CORE PLUGINS -->

    <script src="/js/jquery-1.10.1.min.js" type="text/javascript"></script>

    <script src="/js/jquery-migrate-1.2.1.min.js" type="text/javascript"></script>

    <!-- IMPORTANT! Load jquery-ui-1.10.1.custom.min.js before bootstrap.min.js to fix bootstrap tooltip conflict with jquery ui tooltip -->

    <script src="/js/jquery-ui-1.10.1.custom.min.js" type="text/javascript"></script>

    <script src="/js/bootstrap.min.js" type="text/javascript"></script>

    <!--[if lt IE 9]>

    <script src="/js/excanvas.min.js"></script>

    <script src="/js/respond.min.js"></script>

    <![endif]-->

    <script src="/js/jquery.slimscroll.min.js" type="text/javascript"></script>

    <script src="/js/jquery.blockui.min.js" type="text/javascript"></script>

    <script src="/js/jquery.cookie.min.js" type="text/javascript"></script>

    <script src="/js/jquery.uniform.min.js" type="text/javascript" ></script>

    <!-- END CORE PLUGINS -->

    <!-- BEGIN PAGE LEVEL PLUGINS -->

    <script src="/js/jquery.validate.min.js" type="text/javascript"></script>

    <!-- END PAGE LEVEL PLUGINS -->

    <!-- BEGIN PAGE LEVEL SCRIPTS -->

    <script src="/js/app.js" type="text/javascript"></script>
    <script src="/js/jquery.form.js" type="text/javascript"></script>

    <script src="/js/login.js" type="text/javascript"></script>

    <!-- END PAGE LEVEL SCRIPTS -->

    <script>

        jQuery(document).ready(function() {

          App.init();

          Login.init();

        });

    </script>

    <!-- END JAVASCRIPTS -->

</body>

<!-- END BODY -->

</html>
