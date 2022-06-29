#!/bin/bash
# Author : @laurentC35

contentSurveyList=$(find specifique -name "content.json" -type f)
echo "Adding specific survey content..."
jq -s '{ specifique : map(.specifique[0]) }' $contentSurveyList > specific.json
echo "Specific added."
echo "Adding generic content surveys..."
jq -s 'add' generique/content/content.json specific.json > content.json
rm specific.json
echo "Generic added."


echo "Building folder img...."
imgCourriers=$(find specifique -wholename "*courrier*" -type f)
for survey in $imgCourriers;
    do 
        newFolder=$(dirname img/$(echo $survey | sed "s/specifique\/\|img\///g"))
        mkdir -p $newFolder && cp $survey $newFolder
done
imgResultats=$(find specifique -maxdepth 3 -wholename "*img*" -type f)
for survey in $imgResultats;
    do cp $survey img
done
echo "Folder img built."


echo "Zipping all together..."
zip content.zip content.json img/*

