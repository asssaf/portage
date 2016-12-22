angular.module('overlayjs', [])
.controller('Overlay', function($scope, $http) {
    $http.get('https://api.github.com/repos/asssaf/portage/contents').
        then(function(response) {
            contents = response.data;
            categories = []
            for (entry of contents) {
                if (entry.type == 'dir') {
                    categories.push(entry)
                    //$http.get(entry.url
                }
            }

            $scope.categories = categories
        });
});
