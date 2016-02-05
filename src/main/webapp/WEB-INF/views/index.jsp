<!DOCTYPE HTML>
<html>
  <head>
    <link rel="stylesheet/less" type="text/css" href="assets/mystyle.less"/>
    <script src="https://ajax.googleapis.com/ajax/libs/jquery/1.12.0/jquery.min.js"></script>
  </head>
  <body ng-app="chatApp">
  
    <div ng-controller="ChatCtrl">
     <h1>Chat</h1>    
	 <form ng-show="!showMe">
		<label>User:</label> <br>
		<input type="text" placeholder="Enter your name.." ng-model="user.name"/> <br>
		<button ng-disabled="user.name.length === 0" ng-click="showMe =!showMe; repopulateMessage(); addName(user.name); " >Join</button>
	 </form> 
	  
	  <div ng-show="showMe" >
      	<p>You are in chat <strong>{{user.name}}</strong>!</p>
		<div class="show">
			<p ng-repeat="message in messages | orderBy:'time':true" class="message">
	        <time>{{message.time | date:'HH:mm'}}</time>
	        <span ng-class="{self: message.self}"><strong><{{message.name}}></strong> - {{message.message}}</span>
	        </p>
        </div>
        <div class="showtwo">
            Users online {{users.length}}:
			<p ng-repeat="user in users">
	        <span id="spanId"><strong>- {{user}}</strong></span>
	        </p>
        </div>
        <br>
	    <form >
	        <input type="text" placeholder="Compose a message..." ng-model="user.message" />
	        <br>
	        <button ng-disabled="user.message.length === 0" ng-click="addMessage()">Send</button>
	        <button ng-show="showMe" ng-click="showMe =!showMe; leavchat(); refreshName(user.name)">Leave chat</button>
	        <button  ng-click="cleardiv()">Clear Chat</button>
	    </form>  
      </div>
    </div>
    
    <script src="libs/sockjs/sockjs.min.js" type="text/javascript"></script>
    <script src="libs/stomp-websocket/lib/stomp.min.js" type="text/javascript"></script>
    <script src="libs/angular/angular.min.js"></script>
    <script src="libs/lodash/dist/lodash.min.js"></script>
    <script src="libs/js-cookie/src/js.cookie.js"></script>
    <script src="libs/less/dist/less.js" type="text/javascript"></script>
    <script src="app/app.js" type="text/javascript"></script>
    <script src="app/controllers.js" type="text/javascript"></script>
    <script src="app/services.js" type="text/javascript"></script>
  </body>
</html>
