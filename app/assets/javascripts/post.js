var post = angular.module('Post', ['ngResource']);

post.factory("Post", function($resource) {
  return $resource("post/:id", { id: '@id' }, {
    index:   { method: 'GET', isArray: true, responseType: 'json' },
    update:  { method: 'PUT', responseType: 'json' }
  });
})


post.controller("PostController", function($scope, Post) {
  $scope.posts = Post.index()
  
  $scope.addPost = function() {
    post = Post.save($scope.newPost)

    $scope.posts.push(Post)
    $scope.newPost = {}
  }

  $scope.deletePost = function(index) {
    
    post = $scope.posts[index]
    Post.delete(post)
    $scope.posts.splice(index, 1);
  }
})


