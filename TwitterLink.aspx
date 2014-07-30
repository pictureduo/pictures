<%@ Page Language="C#" AutoEventWireup="true" %>
<%@ Import Namespace="Newtonsoft.Json" %>
<%@ Import Namespace="RestSharp" %>
<script language="c#" runat="server">
    public class TweetObject
    {
        public Status[] statuses { get; set; }
    }

    public class Status
    {
        public string created_at { get; set; }
        public long id { get; set; }
        public string text { get; set; }
        public User user { get; set; }
        public int retweet_count { get; set; }
        public int favorite_count { get; set; }
        public bool favorited { get; set; }
        public bool retweeted { get; set; }
        public string lang { get; set; }
    }

    public class User
    {
        public long id { get; set; }
        public string id_str { get; set; }
        public string name { get; set; }
        public string screen_name { get; set; }
        public string location { get; set; }
        public string description { get; set; }
        public string url { get; set; }
        public string profile_image_url { get; set; }
        public string profile_image_url_https { get; set; }
        public bool default_profile { get; set; }
        public bool default_profile_image { get; set; }
    }
</script>

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

    var tweets = JsonConvert.DeserializeObject<TweetObject>(searchResponse.Content);
    
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
        <% foreach (var item in tweets.statuses) { %>
        <div>
            From user: <%= item.user.name %><br/>
            <%= item.text %>
        </div>
        <%  } %> 
                
    </body>
</html>

