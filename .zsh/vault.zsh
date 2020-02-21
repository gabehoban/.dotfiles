#!/bin/bash

gpgenc () {
	file="${1}"
	if [[ -d "$file" ]]; then
    	    echo "$file is a directory... Creating compressed file"
	    tar czf "$file".tar.gz "$file"
	    file="$file".tar.gz
	else
    	    echo "$file is a File"
	fi

        output="$file".$(date +%s).enc
        gpg --encrypt --armor --output ${output} -r "$KEYID" "$file" && echo "$file -> ${output}"
}

gpgdec () {
        output=$(echo "${1}" | rev | cut -c16- | rev)
        gpg --decrypt --output ${output} "${1}" && echo "${1} -> ${output}"
	if [[ -f "${output}" ]]; then
	    echo "${1} decrypted with no errors."
	    rm -f "${1}"
	else if [[ "${output}" == "*.tar.gz" ]]
	    echo "${output} is a compressed file, decompressing now."
	    tar xvf "$output"
	    rm -f "$output"
	fi
}
