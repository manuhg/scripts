#!/bin/sh
if [ $# -le 2 ]; then
	echo "edit_commit_info.sh <old email> <correct name> <correct email>"
else
	git filter-branch -f --env-filter '
	OLD_EMAIL="'+$1+'"
	CORRECT_NAME="'+$2+'"
	CORRECT_EMAIL="'+$3+'"
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
fi
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