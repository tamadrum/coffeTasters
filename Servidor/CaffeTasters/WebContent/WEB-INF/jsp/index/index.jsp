<!DOCTYPE html5>

<html>
<head>
<title>Caffe Tasters</title>
</head>
<body>

<script>
  window.fbAsyncInit = function() {
    FB.init({
      appId      : '123663028120164',
      xfbml      : true,
      version    : 'v2.8'
    });
  };

  (function(d, s, id){
     var js, fjs = d.getElementsByTagName(s)[0];
     if (d.getElementById(id)) {return;}
     js = d.createElement(s); js.id = id;
     js.src = "//connect.facebook.net/en_US/sdk.js";
     fjs.parentNode.insertBefore(js, fjs);
   }(document, 'script', 'facebook-jssdk'));
</script>

<h1>Caffe Tasters</h1>
<br/>
Quantidade cadastrada: ${quantidade}
<br/><br/>
<div
  class="fb-like"
  data-share="true"
  data-width="450"
  data-show-faces="true">
</div>
</body>
</html>