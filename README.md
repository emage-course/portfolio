### techsecom_engineers_portfolio

This is a Github Action workflow that authenticates with AWS resources without requiring any access token and this job runs all terraform justs.

In summary, if you want to contribute to this project, the simplest way is to:

1. Find a project you want to contribute to
2. Fork it
3. Clone it to your local system
4. Make a new branch
5. Make your changes
6. Push it back to your repo
7. Click the Compare & pull request button
8. Click Create pull request to open a new pull request

```sh
### Clone the project 
git clone https://github.com/kendopx/developers-portfolio.git

### Change to the project 
cd developers-portfoli
git branch -r 

### Create branch  from main 
git checkout -b <yourname>-infra main 

### Make all the neccessary change 

NOTE
The first job belongs to Solomon so do not change `workflow_dispatch:`
The second Job in `yours` so modify as needed

1. Rename `gha-auth-aws-tf-jos/solomon-porfolio-setup` directory # to <yourname>/yourname>portfolio_webpage
2. `variables.tf` change   subdomain_name   = "solomon" # to subdomain_name  = "solomon"<yourname>
3. `main.tf` change host_name  = "www.solomon.kendopx.com" # to  host_name  = "www.<yourname>.kendopx.com" 
4.`versions.tf` change techsecom-engineers-portfolios.tfstate # change to techsecom-engineers-<yourname>.tfstate
5. `.github/workflows/terraform-resource-deployment.yml` # Run a recursive find and replace, replacing "solomon" with "<yourname>"
6. `.github/workflows/terraform-resource-deployment.yml` # For environment_directory # Add your directory <yourname>_portfolio_webpage_setup 

### Stage changes for commit
git add -A 

### Commit changes locally
git commit -m "Hotfix"

### Push changes to a remote repository
git push -u origin <yourname>-infra
git remote -v

git checkout main   

### OR 
./push 
```

### Creating the pull request
1. On GitHub.com, navigate to the main page of the repository.
2. In the "Branch" menu, choose the branch that contains your commits.
3. Above the list of files, in the yellow banner, click Compare & Pull Request to create a pull request for the associated branch.
4. Use the base branch dropdown menu to select the branch you'd like to merge your changes into, then use the compare branch drop-down menu to choose the topic branch you made your changes in.
5. Type a title and description for your pull request.
6. To create a pull request that is ready for review, click Create Pull Request. To create a draft pull request, use the drop-down and select Create Draft Pull Request, then click Draft Pull Request. For more information about draft pull requests, see "About pull requests."


```sh
### To run Terraform Apply
1. Create a `Pull Request`.
2. Navigate to `Actions` and click on the workflow named "All workflows".
3. Select the specific `workflow` you want to run (your workflow).
4. Choose `Run workflow` and execute the workflow from any branch you prefer.
5. Select and update the value to `yes`, then apply the changes.
```

![workflow](./images/workflow1.png)

### Test your portforlio webpage 
Put the URL below into the web browser. The result will determine whether your workflow works or not.
https://<yourname>infra.kendopx.com


### Other useful GitHub commands

```sh
### Create pull request ..git request-pull from local branch to remote master
git request-pull origin/main <yourname>-infra

### Delete branch localkly and Remotely 
git branch -D <yourname>-infra

### Delete remote branch 
git branch -a   
git branch -d <yourname>-infra
git push origin --delete <yourname>-infra

### To commit and push the change via script..

#!/bin/bash

echo "Enter your commit message:"
read commit_message

git add -A
git commit -m "$commit_message"
git push origin <yourname>>-infra
```