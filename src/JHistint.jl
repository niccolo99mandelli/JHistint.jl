module JHistint
export download_collection_values
export print_collection_values
export download_project_infos
export extract_project_id
export download_zip
export getCasesForProject

# Collection Management (acc, blca, etc.)
filepath_collection = "../collection/collectionlist.jsn"
download_collection_values(filepath_collection)
collection_name=print_collection_values(filepath_collection)

# Project Management (TCGA-OR-A5J1, TCGA-OR-A5J2, etc.)
filepath_collection = "../collection/$collection_name.jsn"
download_project_infos(filepath_collection, collection_name)
project_id = extract_project_id(filepath_collection)
filepath_case = "../case/$collection_name.jsn"
casesID_values, casesNAME_values = getCasesForProject(filepath_case, project_id)

# Slides Management
if isdir("../slides/svs/$collection_name")
    println("Update data ...")
else
    mkdir("../slides/svs/$collection_name")
end
for (i, j) in zip(casesID_values, casesNAME_values)
    single_casesID_values, single_casesNAME_values = getCasesForProject(filepath_case, i)
    for (x, y) in zip(single_casesID_values, single_casesNAME_values)
        if isdir("../slides/svs/$collection_name/$j")
        else
            mkdir("../slides/svs/$collection_name/$j")
        end
        filepath_slides = "../slides/svs/$collection_name/"*j*"/"*y*".zip"
        link_slides = "https://api.digitalslidearchive.org/api/v1/folder/$x/download"
        println("DOWNLOADING ... CASE NAME = $j - CASE ID = $i - SINGLE CASE NAME = $y")
        download_zip(link_slides, filepath_slides)
    end
end
end
