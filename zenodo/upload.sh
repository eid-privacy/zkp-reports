#!/usr/bin/env bash
# Creates a Zenodo draft for one report: uploads the PDF from the `latest`
# release and sets the metadata from zenodo/<doc>.json.
# The draft is NOT published: check it on Zenodo and press "Publish" there.
#
# Usage: devbox run upload <ms2|ms4|taxonomy> [deposition-id]
#   deposition-id: id of an already published record -> creates a new version of it
# Env:   ZENODO_TOKEN (scopes deposit:write, deposit:actions)
#        ZENODO_URL   (default https://zenodo.org, use https://sandbox.zenodo.org to test)
set -euo pipefail

doc=${1:?usage: $0 <ms2|ms4|taxonomy> [deposition-id]}
prev=${2:-}
api=${ZENODO_URL:-https://zenodo.org}/api/deposit/depositions
auth=(-H "Authorization: Bearer ${ZENODO_TOKEN:?set ZENODO_TOKEN}")
dir=$(cd "$(dirname "$0")" && pwd)
meta=$dir/$doc.json
[ -f "$meta" ] || { echo "no metadata file $meta" >&2; exit 1; }

case $doc in
  ms2) pdf=eid-privacy-MS2.pdf ;;
  ms4) pdf=eid-privacy-MS4.pdf ;;
  taxonomy) pdf=eid-privacy-taxonomy-eid.pdf ;;
esac

tmp=$(mktemp -d)
trap 'rm -rf "$tmp"' EXIT
curl -fsSL --retry 2 -o "$tmp/$pdf" "https://github.com/eid-privacy/zkp-reports/releases/download/latest/$pdf"

if [ -z "$prev" ]; then
  dep=$(curl -fsS "${auth[@]}" -H "Content-Type: application/json" -d '{}' "$api")
else
  draft=$(curl -fsS "${auth[@]}" -X POST "$api/$prev/actions/newversion" | jq -r .links.latest_draft)
  dep=$(curl -fsS "${auth[@]}" "$draft")
  # The new version starts with the files of the old one.
  for f in $(echo "$dep" | jq -r '.files[].links.self'); do
    curl -fsS "${auth[@]}" -X DELETE "$f"
  done
fi
id=$(echo "$dep" | jq -r .id)
bucket=$(echo "$dep" | jq -r .links.bucket)

curl -fsS "${auth[@]}" --upload-file "$tmp/$pdf" "$bucket/$pdf" > /dev/null
curl -fsS "${auth[@]}" -H "Content-Type: application/json" -X PUT \
  --data-binary "@$meta" "$api/$id" > /dev/null

echo "Draft $id created: $(echo "$dep" | jq -r .links.html)"
echo "Reserved DOI: $(curl -fsS "${auth[@]}" "$api/$id" | jq -r .metadata.prereserve_doi.doi)"
