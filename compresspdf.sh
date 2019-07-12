#!/bin/bash
# Compress a pdf with pdf2ps and ps2pdf

function help {
  echo "Usage: compresspdf input.pdf [output.pdf]"
}


if [[ -e $1 ]] && [[ $(echo $1 | rev | cut -d"." -f1 | rev) == "pdf" ]]; then
  if [[ $2 == "" ]]; then
    output=${1%".pdf"}"_small.pdf"  #Thanks stackexchange! (https://stackoverflow.com/a/16623897)
  else
    output=$2
  fi
  pdf2ps $1 temp.ps
  ps2pdf temp.ps $output
  rm temp.ps
else
  help
fi

  
