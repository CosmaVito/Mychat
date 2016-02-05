(function(angular) {
  angular.module("chatApp.controllers").controller("ChatCtrl", function($scope, ChatService) {
    $scope.messages = [];
    $scope.status = false;
    $scope.users = [];
    $scope.user = {name: "", message: ""};
    $name = "";
    $scope.messagecookies = {};
   
    $(window).bind('beforeunload',function(){	
       if($scope.user.name!="")	{
      	   $(".message").each(function(index, elem){
   	       	$scope.messagecookies[index] = $(elem).html();
   	       });
   	       Cookies.set($scope.user.name, $scope.messagecookies, { expires: 7, path: '' });   	       
       }
	   return 'Are you sure you want to leave?'; 
   }); 

    $scope.repopulateMessage = function(){
    	var messagecookies = Cookies.getJSON($scope.user.name);
    	  if(messagecookies){
    	    Object.keys(messagecookies).forEach(function(element) {
    	      var message = messagecookies[element];
    	      $(".show").append("<p class=\"message\">"+message+"<p>");
    	    });
    	  }
     };
     
     $scope.leavchat = function() { 
     	$(".message").each(function(index, elem){
   	       	$scope.messagecookies[index] = $(elem).html();
   	    });
   	    Cookies.set($scope.user.name, $scope.messagecookies, { expires: 7, path: '' }); 
   	    $(".message").html(""); 
     };
     
     $scope.cleardiv = function() { 
    	$(".message").html(""); 
     };

    $scope.addMessage = function() {
	    ChatService.send($scope.user);
	    $scope.user.message = "";
    };
    
    $scope.addName = function(name) {
    	$scope.user.message = name +" has just entered this chat!!";
        ChatService.send($scope.user);
        $scope.user.message = "";
      };
      
    $scope.refreshName = function(name) {
    	$scope.user.message = name +" has just left this chat!!";
        ChatService.send($scope.user);
        $scope.user.name = ""
      };
    
    ChatService.receive().then(null, null, function(message) {
       $scope.messages.push(message);
      
       if (!_.contains($scope.users, message.name)) {
    	  $scope.users.push(message.name);
       }
      
       if (message.message.indexOf("left") >= 0) {
          $('#spanId').children().each(function() {
         	 var textNode = $(this);
         	 textNode.text(textNode.text().replace("- "+message.name, ""));
         });
         $scope.users.splice( $scope.users.indexOf(message.name), 1 );
       } 
    });
    
  });
})(angular);