//= require lib/angular
var ng_ygo_update = angular.module('ng_ygo_update', []);

ng_ygo_update.controller('ng_ygo_update_index', function($scope){
  $scope.sets_array = []
  
  $scope.fetch_sets = function(){
    jQuery.ajax('/ygo_price_api/sets/').done(function(data){
      $scope.sets_array = data;
      $scope.$apply();
    });
  };
  
});
