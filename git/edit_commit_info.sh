#!/bin/sh

git filter-branch -f --env-filter '
OLD_EMAIL="gk1010100@gmail.com"
CORRECT_NAME="manuhg"
CORRECT_EMAIL="manu@gk1000.me"
if [ "$GIT_COMMITTER_EMAIL" = "$OLD_EMAIL" ]
then
    export GIT_COMMITTER_NAME="$CORRECT_NAME"
    export GIT_COMMITTER_EMAIL="$CORRECT_EMAIL"
fi
if [ "$GIT_AUTHOR_EMAIL" = "$OLD_EMAIL" ]
then
    export GIT_AUTHOR_NAME="$CORRECT_NAME"
    export GIT_AUTHOR_EMAIL="$CORRECT_EMAIL"
fi
' --tag-name-filter cat -- --branches --tags

# #!/bin/sh

# git filter-branch --env-filter '
# OLD_EMAIL="your-old-email@example.com"
# CORRECT_NAME="Your Correct Name"
# CORRECT_EMAIL="your-correct-email@example.com"
# if [ "$GIT_COMMITTER_EMAIL" = "$OLD_EMAIL" ]
# then
#     export GIT_COMMITTER_NAME="$CORRECT_NAME"
#     export GIT_COMMITTER_EMAIL="$CORRECT_EMAIL"
# fi
# if [ "$GIT_AUTHOR_EMAIL" = "$OLD_EMAIL" ]
# then
#     export GIT_AUTHOR_NAME="$CORRECT_NAME"
#     export GIT_AUTHOR_EMAIL="$CORRECT_EMAIL"
# fi
# ' --tag-name-filter cat -- --branches --tags
