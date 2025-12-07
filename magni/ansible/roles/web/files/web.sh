#!/usr/bin/env bash

# website
WEBSITE_REPO="https://github.com/davnpsh/website.git"
WEBSITE_DIR=$(basename "$WEBSITE_REPO" .git)

# blog
BLOG_REPO="https://github.com/davnpsh/blog.git"
BLOG_DIR=$(basename "$BLOG_REPO" .git)

# fetch/update
update_repo() {
    local url="$1"
    local dir="$2"
    
    if [[ -d "$dir/.git" ]]; then
        echo "updating $dir..."
        git -C "$dir" pull
    else
        echo "cloning $dir..."
        git clone "$url"
    fi
}

# prepare/update builder
prepare_builder() {
    local dir="$1"
    local image_name="$dir-builder"
    
    if [[ ! -f "$dir/Dockerfile" ]]; then
        echo "no Dockerfile found in '$dir'."
        echo "first, run: $0 fetch $dir"
        exit 1
    fi
    
    echo "preparing builder for $dir..."
    
    docker build -t "$image_name" "$dir"
}

# actually build :p
build() {
    local dir="$1"
    local image_name="$dir-builder"
    
    # check if the builder exists
    if ! docker image inspect "$image_name" >/dev/null 2>&1; then
        echo "there is no builder for $dir"
        echo "first, run: $0 prepare $dir"
        exit 1
    fi
    
    echo "building $dir..."
    
    docker run --rm -v "$(pwd)/$dir/dist:/app/dist" "$image_name"
}

show_help() {
    cat <<EOF
usage: $0 <command> [subcommand]

commands:

    help                    -   show this message
    up                      -   bring the pages up
    down                    -   bring them down
    fetch <website|blog>    -   pull the code
    prepare <website|blog>  -   prepare the builders of the static files
    update <website|blog>   -   build the static files
EOF
}

# handle commands
case "$1" in
    help | "")
        show_help
        ;;
    up)
        docker compose up -d
        ;;
    down)
        docker compose down
        ;;
    fetch)
        case "$2" in
            website)
                update_repo "$WEBSITE_REPO" "$WEBSITE_DIR"
                ;;
            blog)
                update_repo "$BLOG_REPO" "$BLOG_DIR"
                ;;
            *)
                echo "usage: $0 fetch {website|blog}"
                exit 1
                ;;
        esac
        ;;
    prepare)
        case "$2" in
            website)
                prepare_builder "$WEBSITE_DIR"
                ;;
            blog)
                prepare_builder "$BLOG_DIR"
                ;;
            *)
                echo "usage: $0 prepare {website|blog}"
                exit 1
                ;;
        esac
        ;;
    update)
        case "$2" in
            website)
                build "$WEBSITE_DIR"
                ;;
            blog)
                build "$BLOG_DIR"
                ;;
            *)
                echo "usage: $0 update {website|blog}"
                exit 1
                ;;
        esac
        ;;
    *)
        echo "unknown command: $1"
        echo "use '$0 help' for usage."
        exit 1
        ;;
    
esac