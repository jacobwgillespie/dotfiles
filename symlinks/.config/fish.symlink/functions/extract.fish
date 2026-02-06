function extract --argument-names file
    if not test -f "$file"
        echo "'$file' is not a valid file"
        return 1
    end

    switch $file
        case '*.tar.bz2' '*.tbz2'
            tar -jxvf "$file"
        case '*.tar.gz' '*.tgz'
            tar -zxvf "$file"
        case '*.bz2'
            bunzip2 "$file"
        case '*.dmg'
            hdiutil mount "$file"
        case '*.gz'
            gunzip "$file"
        case '*.tar'
            tar -xvf "$file"
        case '*.zip' '*.ZIP'
            unzip "$file"
        case '*.pax'
            cat "$file" | pax -r
        case '*.pax.Z'
            uncompress "$file" --stdout | pax -r
        case '*.Z'
            uncompress "$file"
        case '*'
            echo "'$file' cannot be extracted/mounted via extract()"
            return 1
    end
end
