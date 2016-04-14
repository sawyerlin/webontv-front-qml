import QtQuick 2.2

Source {
    function getResult(channelId, callback) {
        getVodPrograms(channelId, 10, function(result) {
            var categories = [];
            for(var i in result.Categories) {
                var category = result.Categories[i],
                transformedCategory = {
                    id: category.id,
                    name: category.name,
                    size: category.nbPrograms,
                    programs: []
                };
                for (var j in category.Programs) {
                    var program = category.Programs[j];
                    transformedCategory.programs.push({
                        id: program.id,
                        title: program.title,
                        background: config.imageServerPath + program.imageFilepath
                    });
                }
                categories.push(transformedCategory);
            }
            callback(categories);
        });
    }
}
