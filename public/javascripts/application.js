// Place your application-specific JavaScript functions and classes here
// This file is automatically included by javascript_include_tag :defaults

if (yam) {
  yam.config({appId: "OuNI4TJV66HFX2QTbeOhA"});
}

handleYammerLogin = function(resp) {
  if (resp.authResponse) {
    console.log(resp.access_token.token);
    document.getElementById('yammer-login').innerHTML = 'Welcome to Yammer!';
  }
};
