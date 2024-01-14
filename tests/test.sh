#!/bin/bash

pathToFolder=$1
echo -e "\nThe path fodler is ${pathToFolder}\n"
owner=$2 #marrinosnis
token=$3
expectedPackageName=$4 #the name of the package is: com.test-package.using-java-maven

function oneTimeSetUp() {
    script="./findRepoPackageName.sh"  #This path is configured based on the path in the shunit2 action, which runs the tests, specified in the run-tests.yaml
}

function testNoArgumentsProvide() {
    assertEquals "$($script "$pathToFolder")" "You should provide the owner of the repo and the token with the correct access rights"
}

function testOnlyTheNameOfOwnerIsProvided() {
    assertEquals "$($script "$pathToFolder" "$owner")" "You should provide also the token as the second argument"
}

function testExpectedNameOfPackage() {
    assertEquals "$("$script" "$pathToFolder" "$owner" "$token")" "$expectedPackageName"
}

shift $#

source shunit2