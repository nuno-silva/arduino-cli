#! /bin/bash

set -e

repo=${IMAGE_NAME:-nuno351/arduino-cli}

DATE=$(date -u +%Y%m%d)
DATE=${3:-$DATE}

VERSION="$(git remote get-url origin && git describe --tags --always)" || VERSION=dev
REPO="https://github.com/nuno-silva/arduino-cli"

tag_date="$DATE"

echo building tag $tag

DOCKER_BUILDKIT=1 docker build \
	--file Dockerfile \
	--build-arg VERSION="${VERSION}" \
	--build-arg DATE="${DATE}" \
	--label "org.opencontainers.image.source=${REPO}" \
	--label "org.opencontainers.image.version=$(echo "$VERSION" | tail -n1)" \
	--progress plain \
	--tag $repo:$tag_date .

echo
docker images $repo:$tag_date

echo
echo "Done after $((SECONDS/60)) min $((SECONDS%60)) sec"

echo "To publish, run:"
echo
echo " docker push $repo:$tag_date"
echo
