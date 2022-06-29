#!/bin/bash
# Author : @laurentC35

surveyList=$(find specifique -name "content.json" -type f)
echo "Adding specific survey content..."
jq -s '{ specifique : map(.specifique[0]) }' $surveyList > specific.json
echo "Specific added."
echo "Adding generic content surveys..."
jq -s 'add' generique/content/content.json specific.json > content.json
rm specific.json
echo "Generic added."