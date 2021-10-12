#!/bin/sh

while getopts 'n:d:c:o:' o; do
    case $o in 
        n) plugin_name="$OPTARG" ;;
        d) plugin_desc="$OPTARG" ;;
        c) class_name="$OPTARG" ;;
        o) out_dir="$OPTARG" ;;
    esac
done

usage()
{
    echo "Generate skeleton NickelPlugin"
    echo " "
    echo "USAGE: gen-plugin.sh -n <plugin name> -d <plugin description> -c <class name> -o <output dir>"
    exit 1
}

[ -z "$plugin_name" ] && echo "Missing plugin name" && usage
[ -z "$plugin_desc" ] && echo "Missing plugin description" && usage
[ -z "$class_name" ] && echo "Missing class name" && usage
[ -z "$out_dir" ] && echo "Missing plugin name" && usage

file_name="$class_name"
lib_name="$(echo ${class_name} | tr '[A-Z]' '[a-z]')"

cp -r ./src ./include "$out_dir"

mv "${out_dir}/src/TemplatePlugin.cpp" "${out_dir}/src/${file_name}.cpp"
sed -i -e "s/TemplatePlugin/${class_name}/g" "${out_dir}/src/${file_name}.cpp"

mv "${out_dir}/include/TemplatePlugin.hpp" "${out_dir}/include/${file_name}.hpp"
sed -i -e "s/TemplatePlugin/${class_name}/g" \
    -e "s/TEMPLATE_PLUGIN_H/$(echo ${class_name} | tr '[a-z]' '[A-Z]')_H/g" \
    "${out_dir}/include/${file_name}.hpp"

mv "${out_dir}/include/TemplatePlugin.json" "${out_dir}/include/${file_name}.json"
sed -i -e "s/TemplatePlugin/${plugin_name}/g" \
    -e "s/Template Plugin/${plugin_desc}/g" \
    "${out_dir}/include/${file_name}.json"

cp ./TemplatePlugin.pro "${out_dir}/${lib_name}.pro"
sed -i -e "s/TemplatePlugin/${class_name}/g" "${out_dir}/${lib_name}.pro"
