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
    searchRequest.AddParameter("q", "#MoneyLisa");
    var searchResponse = twitterClient.Execute(searchRequest);

    var tweets = JsonConvert.DeserializeObject<TweetObject>(searchResponse.Content);
    
    %>


<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="utf-8">
    <meta http-equiv="X-UA-Compatible" content="IE=edge">
    <meta name="viewport" content="width=device-width, initial-scale=1">
    <meta name="description" content="">
    <meta name="author" content="">

    <title>Picture Duo</title>

    <!-- Bootstrap core CSS -->
    <link href="css/bootstrap.min.css" rel="stylesheet">

    <!-- HTML5 shim and Respond.js IE8 support of HTML5 elements and media queries -->
    <!--[if lt IE 9]>
    <script src="https://oss.maxcdn.com/html5shiv/3.7.2/html5shiv.min.js"></script>
    <script src="https://oss.maxcdn.com/respond/1.4.2/respond.min.js"></script>
    <![endif]-->

    <style>
        .redpanel{
            margin-top: 150px;
            padding-top: 25px;
            background-color: #ff1b2c;
        }
        h1{
            font-size:70px;
        }

        .single-tweet{

            color: red;
            padding: 5px 5px 5px 5px;

        }
    </style>
    <script src="https://ajax.googleapis.com/ajax/libs/jquery/1.11.1/jquery.min.js"></script>

</head>

<body>



<div class="navbar navbar-fixed-top" role="navigation">
    <div class="container">
        <div class="navbar-header">
            <button type="button" class="navbar-toggle" data-toggle="collapse" data-target=".navbar-collapse">
                <span class="sr-only">Toggle navigation</span>
                <span class="icon-bar"></span>
                <span class="icon-bar"></span>
                <span class="icon-bar"></span>
            </button>
            <a class="navbar-brand" href="#">Picture Duo - for Comic Relief</a>
        </div>
        <div class="collapse navbar-collapse">
            <ul class="nav navbar-nav">
                <li><a href="index.html">Home</a></li>
                <li class="active"><a href="#">Gallery</a></li>
            </ul>
        </div><!--/.nav-collapse -->
    </div>
</div>

<div class="redpanel">
    <div class="container">
    <!-- Example row of columns -->
        <div class="row">
            <div class="col-md-3">
            </div>

            <div class="col-md-6">
                <div>
                    <p></p>
                    <p></p>
                    <img src="moneymona.png"  width="100%" />
                </div>
            </div>
            <div class="col-md-3" align="right">
                    <br>
                    <br>
                    <br>
                    <br>
                    <br>
                    <br>
                    <h1><strong><center><font face="century gothic" color="white">#MoneyLisa</center></strong></h1>

            </div>

        </div>

    </div>
</div>
<div class="container">

        <div class="row">
            <div class="col-md-6 col-md-offset-3">

                    <% foreach (var item in tweets.statuses) { %>
                    <div class="pull-left single-tweet">
                        <img src="<%= item.user.profile_image_url %>" /><br/>
                        From user: <%= item.user.name %><br/>
                        <%= item.text %>
                    </div>

                    <%  } %>
            </div>
        </div>


     <hr>
    <footer>
        <p>&copy; Company 2014</p>
    </footer>
</div> <!-- /container -->


<script src="js/bootstrap.min.js"></script>
</body>
</html>
