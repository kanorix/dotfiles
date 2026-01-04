# git sw
function fzf-git-switch() {
    if [ $(git branch -vv | wc -l) -eq 1 ]; then
        # ブランチが1つだけなので何もしない
        return 0
    fi
    local branch=$(git branch -vv | fzf --height 100% --preview "echo {} | sed -E 's/^[\* ]* ([^ ]*).*/\1/' | xargs git show --color=always --oneline --name-only ")
    git switch $(echo $branch | awk '{print $1}')
}

# git ss
function git-stash-push() {
    local date=$(date '+%Y/%m/%d %H:%M:%S')
    git stash push -u -m "[$date]: ${1:-saved}"
}

# git sp
function fzf-git-stash-pop() {
    local target_stash=$(git stash list | fzf --query=$1 --preview "echo {} | sed -E 's/^(stash@{.+}).*/\1/' | xargs git stash show --include-untracked --stat --color=always")
    local stash_name=$(echo $target_stash | awk -F '[:]' '{print $1}')
    if [ -z "$stash_name" ]; then
        # キャンセル
        return 0
    fi

    echo $(git rev-parse $stash_name)
    # git stash pop --index $stash_name
    git stash apply --index $stash_name
}

# git save
function git-savepoint() {
    git-stash-push
    fzf-git-stash-pop stash@{0}
}

# ctrl+r -> 履歴見れる

function fd() {
    find ${1:-`pwd`} -path '*/\.*' -prune -o -type d -print 2> /dev/null
}
