#made by szrce  


mkdir -p qwork
cd qwork

main_category="Unknown"

while IFS= read -r line; do

    total=0

    if ! lynx --connect_timeout=3 --read_timeout=3  --dump "$line" > "$line.dump"; then
        echo "Error:$line" > error.log
    fi

    if [ -f "$line.dump" ]; then
        category_newsandmedia="haber gazete sondakika magazin"
        category_pornography="porn sex adult"
        category_socialmedia="facebook twitter"

        for category in "newsandmedia" "pornography" "socialmedia"; do

            category_keywords_var="category_$category"
            category_keywords="${!category_keywords_var}"

            for keyword in $category_keywords; do
                count=$(grep -o "$keyword" "$line.dump" | wc -l)
                if grep -q "$keyword" "$line.dump"; then
                if [ "$count" -gt 20 ]; then
                      total=$(expr "$total" + "$count")
                       echo "$line : $keyword : $total ";
                        main_category=$category
                        echo "$line" >> $main_category.domains
                        break 2
                    fi
                fi
            done;
        done
        rm "$line.dump";
    fi
done < ../domains1
