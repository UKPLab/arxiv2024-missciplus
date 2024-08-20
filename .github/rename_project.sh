#!/usr/bin/env bash
while getopts a:n:u:d: flag
do
    case "${flag}" in
        a) author=${OPTARG};;
        n) name=${OPTARG};;
        u) urlname=${OPTARG};;
        d) description=${OPTARG};;
    esac
done

echo "Author: $author";
echo "Project Name: $name";
echo "Project URL name: $urlname";
echo "Description: $description";

echo "Renaming project..."

original_author="UKPLab"
original_name="arxiv2024_missciplus"
original_urlname="arxiv2024-missciplus"
original_description="Awesome arxiv2024_missciplus created by UKPLab"
# Iterate over all files in the repository
git ls-files | while read -r filename; do
    # Exclude .github/workflows/rename_project.yml from renaming
    if [[ "$filename" != ".github/workflows/rename_project.yml" ]]; then
        sed -i "s/$original_author/$author/g" "$filename"
        sed -i "s/$original_name/$name/g" "$filename"
        sed -i "s/$original_urlname/$urlname/g" "$filename"
        sed -i "s/$original_description/$description/g" "$filename"
        echo "Renamed $filename"
    else
        echo "Skipping $filename"
    fi
done

mv "$original_name" "$name"

# This command runs only once on GHA!
rm -rf .github/template.yml
