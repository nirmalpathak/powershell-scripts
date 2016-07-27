<# Version: 0.1
   License: GPLv2 (https://www.gnu.org/licenses/gpl-2.0.txt)
   Author: Nirmal Pathak.
   Purpose: PS script to migrate projects TFS to git & push to remote git repo.
#>

[string]$TFSURL = $(Read-Host "Input TFS URL: ")
#[string]$TFSURL = "http://192.168.2.194:8080/tfs/QA"

[string]$TPNAME = $(Read-Host "Input Team Project Name: ")

[string]$LOCALFOLDER = $(Read-Host "Input Local Folder Path: ")
#[string]$LOCALFOLDER = "D:\Nirmal.Pathak\qa-cloud"

[string]$REMOTEURL = $(Read-Host "Input Repository's remote URL: ")
#[string]$REMOTEURL = "https://user@bitbucket.org/user/qa-cloud.git"
 
#Cloning Data in Repository
git.exe tfs clone -l $TFSURL $/$TPNAME $LOCALFOLDER

#Renaming 'master' branch to 'oldbranch' & re-creating orphan 'master' branch with few sample directories then push with flag '--all' to bitbucket.
cd $LOCALFOLDER
git.exe remote add origin $REMOTEURL
git.exe branch
git.exe branch -m old-tfs-data
git.exe checkout --orphan master
git.exe rm -rf .
mkdir Tests,Reports,Cases
$null > Tests/.gitkeep  
$null > Reports/.gitkeep
$null > Cases/.gitkeep
git.exe add .
git.exe commit -m "Inital commit" .
git.exe branch
git.exe push -f --all origin
