<%@ Page Language="C#" AutoEventWireup="true" %>
<%@ Import Namespace="System.IO" %>
<%@ Import Namespace="System.Net" %>
<%@ Import Namespace="Newtonsoft.Json" %>
<%@ Import Namespace="RestSharp" %>
<%
    var authHeader = "fzMV0cnKOceFTRVhiuFVEM48G" + ":" + "n2je5qm8bu6fCWc6mcYjjBQg4rCA4KsfGzH3a9WO0aKAHDlPC5";

    var twitterClient = new RestClient
    {
        BaseUrl = "https://api.twitter.com"
    };
    var tokenRequest = new RestRequest("/oauth2/token", Method.POST);
    tokenRequest.AddHeader("Authorization", "Basic " + Convert.ToBase64String(Encoding.ASCII.GetBytes(authHeader)));
    tokenRequest.AddParameter("grant_type", "client_credentials");
    var tokenResponse = twitterClient.Execute(tokenRequest);
    var token = JsonConvert.DeserializeAnonymousType(tokenResponse.Content, new {access_token = ""});


    var searchRequest = new RestRequest("/1.1/search/tweets.json", Method.GET);
    searchRequest.AddHeader("Authorization", "Bearer " + token.access_token);
    searchRequest.AddParameter("q", "lolcat");
    var searchResponse = twitterClient.Execute(searchRequest);

    var temp = searchResponse.Content;
    %>
<html>
    <head>
        <Title>Our twitter feed</Title>
    </head>
    <Style>
        body {
            background-color: lightblue;
        }
    </Style>
    <body> 
        <%= temp %>        
    </body>
</html>

