#!/bin/sh

m="master"
d="develop"
hf="hotfix"
rl="release"

function CreateNewRepository() {
  echo "Enter the new repository name:"
  read foldername
  mkdir $foldername
  echo ">> folder '$foldername' created"
  cd $foldername

  git init
  git checkout -b $m
  touch master.txt && git add . && git commit -m $m
  git checkout -b $d
  touch delevop.txt && git add . && git commit -m $d
}

function CreateNewBranch() {
  echo "Enter the new branch name:"
  read newBranchName
  git checkout -b $newBranchName && echo ">> $newBranchName branch created"
}

function CreateNewFeature() {
  echo "Enter the new feature name:"
  read newFeatureName
  git checkout -b $newFeatureName
  for j in $(seq 1 3); do
    echo $j"\n" >>"f-$newFeatureName"
    git add . && git commit -m "f-$newFeatureName commit $j"
  done
}

function CheckoutBranch {
  echo "Checkout to:"
  git branch
  read branchName
  git checkout $branchName
}

function GitGraph {
  git log --graph --all --pretty=oneline
}

function AddCommit {
  echo "new code" >> code.txt && git add . && git commit -m "$(date +%Y%m%d-%H:%M:%S)"
}

function Merge {
    echo "You are in:"
    git branch --show-current
    echo "What branch do you want to merge:"
    git branch
    read mergeBranch
    echo "Options: ?"
    read mergeOptions
    git merge $mergeOptions $mergeBranch
}

function Rebase {
    echo "Enter the branch name where you want to rebase current branch:"
    read rebaseTo
    echo "Options: ?"
    read rebaseOptions
    git rebase $rebaseOptions $rebaseTo
}

function Custom {
  echo "Enter your command:"
  read command
  $command
}

echo "================================================================="
echo "Hello, I am GitProbe - a test environment for Git workflows"
echo "================================================================="
echo "Please, choose what you want to do:"

OPTIONS="Quit GitGraph CreateNewRepository CreateNewBranch CreateNewFeature CheckoutBranch AddCommit Merge Rebase Custom"
select opt in $OPTIONS; do
  if [ "$opt" = "Quit" ]; then
    cd ..
    exit
  elif [ "$opt" = "GitGraph" ]; then
    GitGraph
  elif [ "$opt" = "CreateNewRepository" ]; then
    CreateNewRepository
  elif [ "$opt" = "CreateNewBranch" ]; then
    CreateNewBranch
  elif [ "$opt" = "CreateNewFeature" ]; then
    CreateNewFeature
  elif [ "$opt" = "CheckoutBranch" ]; then
    CheckoutBranch
  elif [ "$opt" = "AddCommit" ]; then
    AddCommit
  elif [ "$opt" = "Merge" ]; then
    Merge
  elif [ "$opt" = "Rebase" ]; then
    Rebase
  elif [ "$opt" = "Custom" ]; then
    Custom
  else
    clear
    echo bad option
  fi
done
