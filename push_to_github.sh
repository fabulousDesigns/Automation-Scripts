#? random commit_name
commit_name() {
  echo "commit-$(date +%s)"
}

read -p "Enter commit Name or continue with a random name: " COMMIT_NAME

[ -z "$COMMIT_NAME" ] && COMMIT_NAME=$(commit_name)

echo "******************************************************************************************************************************************************"
echo "                                                   Pushing to Github: $COMMIT_NAME                           "
echo "******************************************************************************************************************************************************"

git add .

git commit -m "$COMMIT_NAME"

[ $? -ne 0 ] && echo "Failed to commit changes: $COMMIT_NAME" && exit 1  || echo "Committed Successfully: $COMMIT_NAME"

git push

[ $? -ne 0 ] && echo "Failed to push to Github: $COMMIT_NAME" && exit 1  || echo "Pushed Successfully to Github: $COMMIT_NAME"

echo "******************************************************************************************************************************************************"
#  The script will prompt you to enter the commit name and tag. It will then add all the files, commit the changes, and push the changes to the main branch on GitHub.
#  Run the script using the following command:
#  $ bash push_to_github.sh
#  You will be prompted to enter the commit name and tag. Enter the required details and press Enter. The script will add all the files, commit the changes, and push the changes to the main branch on GitHub.
#  Conclusion
